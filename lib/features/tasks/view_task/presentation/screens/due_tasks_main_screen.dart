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

class DueTasksMainScreen extends StatefulWidget {
  const DueTasksMainScreen({super.key});

  @override
  State<DueTasksMainScreen> createState() => _DueTasksMainScreenState();
}

class _DueTasksMainScreenState extends State<DueTasksMainScreen> {
  final TaskDetailsCubit _taskDetailsCubit = sl<TaskDetailsCubit>();
  bool _isErrorPopupShowing = false;

  @override
  void initState() {
    super.initState();
    _taskDetailsCubit.getDueTasksList(null, null);
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
                      pageTitle: 'Overdue tasks',
                    ),
                    body: Center(
                      child: SizedBox(
                        width: 370,
                        child: (state.getDueTasksListStatus == TaskDetailsStatus.success) ? TasksList(
                          tasks: state.dueTasks,
                          tileColor: Clr.of(context).salmon.withOpacity(0.7),
                          emptyListText:
                          'There are no overdue tasks',
                        ) : const DefaultSkeletonList(),
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
