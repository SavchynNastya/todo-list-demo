import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/widgets/app_bars/app_bar.dart';
import 'package:todolist/core/widgets/colored_safe_area.dart';
import 'package:todolist/core/widgets/empty_states/default_empty_state.dart';
import 'package:todolist/core/widgets/modal_windows/custom_action_dialog.dart';
import 'package:todolist/core/widgets/skeletons/default_skeleton_list.dart';
import 'package:todolist/core/widgets/system_overlay.dart';
import 'package:todolist/core/widgets/tab_bars/custom_tab_bar.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_state.dart';
import 'package:todolist/features/sections_board/presentation/widgets/task_board_tab_pages.dart';
import 'package:todolist/features/sections_board/presentation/widgets/tasks_page.dart';
import 'package:todolist/features/tasks/create_task/presentation/widgets/create_task_floating_action_button.dart';
import 'package:todolist/injection_container.dart';

class TasksBoardMainScreen extends StatefulWidget {
  final int initialTab;

  const TasksBoardMainScreen({super.key, required this.initialTab});

  @override
  State<TasksBoardMainScreen> createState() => _TasksBoardMainScreenState();
}

class _TasksBoardMainScreenState extends State<TasksBoardMainScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final SectionCubit _sectionCubit = sl<SectionCubit>();
  bool _isErrorPopupShowing = false;
  List<Tab> _tabs = <Tab>[];
  bool _isTabControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _sectionCubit.getSectionsList();
    _sectionCubit.stream.listen((state) {
      if (state.sections != null && !_isTabControllerInitialized) {
        _initializeTabController(state.sections!);
      }
    });
  }

  void _initializeTabController(List sections) {
    _tabs = sections.map((e) => Tab(text: e.name.toUpperCase())).toList();
    _tabController = TabController(
      length: sections.length,
      vsync: this,
      initialIndex: widget.initialTab,
    );
    _isTabControllerInitialized = true;

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _sectionCubit.getTasksList(
              _sectionCubit.state.sections?[_tabController.index].id, null);
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemOverlayWrapper(
      style: SystemUiOverlayStyle.dark,
      child: ColoredSafeArea(
        child: PopScope(
          canPop: false,
          child: BlocConsumer<SectionCubit, SectionState>(
            bloc: _sectionCubit,
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              if (state.getSectionsListStatus == SectionStatus.failure) {
                if (!_isErrorPopupShowing) {
                  setState(() {
                    _isErrorPopupShowing = true;
                  });
                  showError(context);
                }
              }
            },
            builder: (context, state) {
              if (state.sections != null && state.sections!.isNotEmpty) {
                if (!_isTabControllerInitialized) {
                  _initializeTabController(state.sections!);
                }
                return Scaffold(
                  floatingActionButton: CreateTaskFloatingActionButton(
                    onPressed: () => context.push('/create-task'),
                  ),
                  resizeToAvoidBottomInset: false,
                  backgroundColor:
                  Clr.of(context).lightMilkyBaseColor.withOpacity(0.6),
                  appBar: const DefaultAppBar(
                    pageTitle: 'Tasks Board',
                  ),
                  body: Stack(
                    children: [
                      Column(
                        children: [
                          CustomTabBar(
                            tabController: _tabController,
                            tabs: state.sections!
                                .map((e) => Tab(text: e.name.toUpperCase()))
                                .toList(),
                          ),
                          Expanded(
                            child: TaskBoardTabPages(
                              tabs: _tabs,
                              tabController: _tabController,
                              pages: state.sections!.map((section) {
                                return TasksPage(section: section);
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state.getSectionsListStatus == SectionStatus.success &&
                  (state.sections == null || state.sections!.isEmpty)) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor:
                  Clr.of(context).lightMilkyBaseColor.withOpacity(0.6),
                  appBar: const DefaultAppBar(
                    pageTitle: 'Tasks Board',
                  ),
                  body: const DefaultEmptyState(
                    emptyText: 'There are no sections yet.',
                    routeName: 'Create a task section',
                    navigateTo: '/create-section',
                  ),
                );
              } else {
                return const Center(
                  child: DefaultSkeletonList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  showError(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CustomActionDialog(
        title: 'Error',
        helpText:
        'There was a problem loading the data. Please try again later.',
        applyButtonText: 'Ok',
        onApplyButtonTap: () {
          context.pop();
        },
      ),
    ).then(
          (value) => setState(() {
        _isErrorPopupShowing = false;
      }),
    );
  }
}
