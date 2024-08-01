import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/core/style/colors/colors.dart';
import 'package:todolist/core/widgets/app_bars/app_bar.dart';
import 'package:todolist/core/widgets/colored_safe_area.dart';
import 'package:todolist/core/widgets/modal_windows/custom_action_dialog.dart';
import 'package:todolist/core/widgets/skeletons/default_skeleton_list.dart';
import 'package:todolist/core/widgets/system_overlay.dart';
import 'package:todolist/features/tasks/create_task/presentation/widgets/create_task_floating_action_button.dart';
import 'package:todolist/features/tasks/view_task/presentation/cubit/view_task_cubit.dart';
import 'package:todolist/features/tasks/view_task/presentation/cubit/view_task_state.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/tasks_list.dart';
import 'package:todolist/injection_container.dart';

class TodayTasksMainScreen extends StatefulWidget {
  const TodayTasksMainScreen({super.key});

  @override
  State<TodayTasksMainScreen> createState() => _TodayTasksMainScreenState();
}

class _TodayTasksMainScreenState extends State<TodayTasksMainScreen> {
  final TaskDetailsCubit _taskDetailsCubit = sl<TaskDetailsCubit>();
  bool _isErrorPopupShowing = false;

  @override
  void initState() {
    super.initState();
    _taskDetailsCubit.getTodayTasksList(null, null);
  }

  @override
  Widget build(BuildContext context) {
    return SystemOverlayWrapper(
      style: SystemUiOverlayStyle.dark,
      child: ColoredSafeArea(
        child: PopScope(
          canPop: false,
          child: BlocConsumer<TaskDetailsCubit, TaskDetailsState>(
            bloc: _taskDetailsCubit,
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              if (state.getTodayTasksListStatus == TaskDetailsStatus.failure) {
                if (!_isErrorPopupShowing) {
                  setState(() {
                    _isErrorPopupShowing = true;
                  });
                  showError(context);
                }
              }
            },
            builder: (context, state) {
              return Scaffold(
                  floatingActionButton: CreateTaskFloatingActionButton(
                    onPressed: () => context.go('/create-task'),
                  ),
                  resizeToAvoidBottomInset: false,
                  backgroundColor:
                  Clr.of(context).lightMilkyBaseColor.withOpacity(0.6),
                  appBar: const DefaultAppBar(
                    pageTitle: 'Due today',
                  ),
                  body: Center(
                    child: SizedBox(
                      width: 370,
                      child: (state.getTodayTasksListStatus == TaskDetailsStatus.success) ? TasksList(
                        tasks: state.todayTasks,
                        tileColor: Clr.of(context).salmon.withOpacity(0.7),
                        emptyListText:
                        'There are no tasks due today. You can relax a bit.',
                      ): const DefaultSkeletonList(),
                    ),
                  )
              );
            },
          ),
        ),
      ),
    );
  }

  // TODO: move into separate component and remove code duplicates
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
