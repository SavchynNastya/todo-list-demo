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
import 'package:todolist/features/history/presentation/cubit/history_cubit.dart';
import 'package:todolist/features/history/presentation/cubit/history_state.dart';
import 'package:todolist/features/history/presentation/widgets/task_history_list.dart';
import 'package:todolist/features/tasks/create_task/presentation/widgets/create_task_floating_action_button.dart';
import 'package:todolist/features/tasks/view_task/presentation/widgets/tasks_list.dart';
import 'package:todolist/injection_container.dart';

class TasksHistoryMainScreen extends StatefulWidget {
  const TasksHistoryMainScreen({super.key});

  @override
  State<TasksHistoryMainScreen> createState() => _TasksHistoryMainScreenState();
}

class _TasksHistoryMainScreenState extends State<TasksHistoryMainScreen> {
  final HistoryCubit _historyCubit = sl<HistoryCubit>();
  bool _isErrorPopupShowing = false;

  @override
  void initState() {
    super.initState();
    _historyCubit.fetchCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return SystemOverlayWrapper(
      style: SystemUiOverlayStyle.dark,
      child: ColoredSafeArea(
        child: PopScope(
          canPop: false,
          child: BlocConsumer<HistoryCubit, HistoryState>(
            bloc: _historyCubit,
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              if (state.getCompletedTaskListStatus == HistoryStatus.failure) {
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
                    pageTitle: 'History',
                  ),
                  body: Center(
                    child: SizedBox(
                        width: 380,
                        child:
                        (state.getCompletedTaskListStatus == HistoryStatus.success) ?
                        TaskHistoryList(
                          taskHistoryItems: state.completedTasks,
                        ) : const DefaultSkeletonList()
                    ),
                  )
              );
              if (state.getCompletedTaskListStatus == HistoryStatus.success) {
                // return Scaffold(
                //     floatingActionButton: CreateTaskFloatingActionButton(
                //       onPressed: () => context.go('/create-task'),
                //     ),
                //     resizeToAvoidBottomInset: false,
                //     backgroundColor:
                //     Clr.of(context).lightMilkyBaseColor.withOpacity(0.6),
                //     appBar: const DefaultAppBar(
                //       pageTitle: 'History',
                //     ),
                //     body: Center(
                //       child: SizedBox(
                //         width: 370,
                //         child:
                //         TaskHistoryList(
                //           taskHistoryItems: state.completedTasks,
                //         )
                //       ),
                //     )
                // );
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
