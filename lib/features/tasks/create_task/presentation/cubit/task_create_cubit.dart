import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/features/tasks/create_task/domain/repositories/create_task_repository.dart';
import 'package:todolist/features/tasks/create_task/presentation/cubit/task_create_state.dart';


class CreateTaskCubit extends Cubit<TaskCreateState> {
  final CreateTaskRepository taskCreateRepository;

  CreateTaskCubit({required this.taskCreateRepository})
      : super(const TaskCreateState());

  createTask(
    String sectionId,
    String content,
    String? description,
    List<String>? labels,
    int? priority,
    String? dueDatetime,
    int? duration,
    String? durationUnit,
  ) async {
    emit(state.copyWith(
      createTaskStatus: TaskCreateStatus.loading,
    ));

    final result = await taskCreateRepository.createTask(
      sectionId,
      content,
      description,
      labels,
      priority,
      dueDatetime,
      duration,
      durationUnit,
    );

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            createTaskStatus: TaskCreateStatus.failure,
          ),
        );
      },
      (data) => emit(
        state.copyWith(
          task: data,
          createTaskStatus: TaskCreateStatus.success,
        ),
      ),
    );
  }

  createLabel(
    String name,
    int? order,
    Color? color,
    bool? isFavorite,
  ) async {
    emit(state.copyWith(
      createTaskStatus: TaskCreateStatus.loading,
    ));

    final result = await taskCreateRepository.createLabel(
      name,
      order,
      color,
      isFavorite,
    );

    result.fold(
      (failure) {
        return emit(
          state.copyWith(
            createLabelStatus: TaskCreateStatus.failure,
          ),
        );
      },
      (data) => emit(
        state.copyWith(
          labels: [data],
          createLabelStatus: TaskCreateStatus.success,
        ),
      ),
    );
  }
}
