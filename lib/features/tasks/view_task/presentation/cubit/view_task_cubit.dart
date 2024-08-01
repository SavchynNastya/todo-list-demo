import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/features/sections_board/domain/repositories/section_repository.dart';
import 'package:todolist/features/tasks/view_task/domain/entities/attachment.dart';
import 'package:todolist/features/tasks/view_task/domain/repositories/view_task_repository.dart';
import 'package:todolist/features/tasks/view_task/presentation/cubit/view_task_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  final TaskDetailsRepository taskDetailsRepository;
  final SectionRepository sectionRepository;

  TaskDetailsCubit(
      {required this.taskDetailsRepository, required this.sectionRepository})
      : super(const TaskDetailsState());

  getTaskDetails(String taskId) async {
    emit(state.copyWith(getTaskDetailsStatus: TaskDetailsStatus.loading));

    final result = await taskDetailsRepository.getTaskDetails(taskId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          getTaskDetailsStatus: TaskDetailsStatus.failure,
        ),
      ),
      (task) => emit(
        state.copyWith(
          task: task,
          getTaskDetailsStatus: TaskDetailsStatus.success,
        ),
      ),
    );
  }

  createComment(
    String taskId,
    String content,
    Attachment? attachment,
  ) async {
    emit(state.copyWith(createCommentStatus: TaskDetailsStatus.loading));

    final result = await taskDetailsRepository.createComment(
      taskId,
      content,
      attachment,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          createCommentStatus: TaskDetailsStatus.failure,
        ),
      ),
      (createdComment) => emit(
        state.copyWith(
          createCommentStatus: TaskDetailsStatus.success,
        ),
      ),
    );

    getTaskComments(taskId);
  }

  getTaskComments(String taskId) async {
    emit(state.copyWith(getTaskCommentsStatus: TaskDetailsStatus.loading));

    final result = await taskDetailsRepository.getTaskComments(taskId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          getTaskCommentsStatus: TaskDetailsStatus.failure,
        ),
      ),
      (comments) => emit(
        state.copyWith(
          comments: comments,
          getTaskCommentsStatus: TaskDetailsStatus.success,
        ),
      ),
    );
  }

  updateTask(
    String taskId,
    String? content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  ) async {
    emit(state.copyWith(updateTaskStatus: TaskDetailsStatus.loading));

    final result = await taskDetailsRepository.updateTask(
      taskId,
      content,
      description,
      labels,
      priority,
      dueDatetime,
      duration,
      durationUnit,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          updateTaskStatus: TaskDetailsStatus.failure,
        ),
      ),
      (updatedTask) => emit(
        state.copyWith(
          task: updatedTask,
          updateTaskStatus: TaskDetailsStatus.success,
        ),
      ),
    );
  }

  deleteTask(String taskId) async {
    emit(state.copyWith(deleteTaskStatus: TaskDetailsStatus.loading));

    final result = await taskDetailsRepository.deleteTask(taskId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteTaskStatus: TaskDetailsStatus.failure,
        ),
      ),
      (_) => emit(
        state.copyWith(
          deleteTaskStatus: TaskDetailsStatus.success,
        ),
      ),
    );
  }

  closeTask(String taskId) async {
    emit(state.copyWith(closeTaskStatus: TaskDetailsStatus.loading));

    final result = await taskDetailsRepository.closeTask(taskId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          closeTaskStatus: TaskDetailsStatus.failure,
        ),
      ),
      (_) => emit(
        state.copyWith(
          closeTaskStatus: TaskDetailsStatus.success,
        ),
      ),
    );
  }

  getTodayTasksList(String? sectionId, String? label) async {
    DateTime now = DateTime.now();
    String todayDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    emit(state.copyWith(
      getTodayTasksListStatus: TaskDetailsStatus.loading,
    ));

    final result = await sectionRepository.getTasksList(sectionId, label);

    result.fold(
          (failure) {
        return emit(
          state.copyWith(
            getTodayTasksListStatus: TaskDetailsStatus.failure,
          ),
        );
      },
          (data) {
        return emit(state.copyWith(
          todayTasks: data.where((task) {
            if (task.due == null) return false;
            if (task.due!.date != todayDate) return false;
            if (task.due!.datetime != null && DateTime.parse(task.due!.datetime!).isAfter(now)) return true;
            if (task.due!.date == todayDate && task.due!.datetime == null) return true;
            return task.due!.datetime != null ? DateTime.parse(task.due!.datetime!).isAfter(now) : false;
          }).toList(),
          getTodayTasksListStatus: TaskDetailsStatus.success,
        ));
      },
    );
  }

  getDueTasksList(String? sectionId, String? label) async {
    DateTime now = DateTime.now();
    String todayDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    emit(state.copyWith(
      getDueTasksListStatus: TaskDetailsStatus.loading,
    ));

    final result = await sectionRepository.getTasksList(sectionId, label);

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            getDueTasksListStatus: TaskDetailsStatus.failure,
          ),
        );
      },
      (data) {
        return emit(state.copyWith(
          dueTasks: data.where((task) {
            if (task.due == null) return false;
            DateTime taskDueDate = DateTime.parse(task.due!.date);
            if (taskDueDate.isBefore(DateTime.parse(todayDate))) return true;
            if (task.due!.date == todayDate && task.due!.datetime != null) {
              DateTime taskDueDateTime = DateTime.parse(task.due!.datetime!);
              if (taskDueDateTime.isBefore(now)) {
                return true;
              }
            }
            return false;
          }).toList(),
          getDueTasksListStatus: TaskDetailsStatus.success,
        ));
      },
    );
  }
}
