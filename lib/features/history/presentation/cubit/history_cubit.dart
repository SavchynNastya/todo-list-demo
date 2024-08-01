import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/features/history/domain/repositories/history_repository.dart';
import 'package:todolist/features/history/presentation/cubit/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository historyRepository;

  HistoryCubit({required this.historyRepository}) : super(const HistoryState());

  fetchCompletedTasks() async {
    emit(state.copyWith(getCompletedTaskListStatus: HistoryStatus.loading));

    final result = await historyRepository.getCompletedTaskList();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getCompletedTaskListStatus: HistoryStatus.failure,
          ),
        );
      },
      (tasks) {
        emit(
          state.copyWith(
            getCompletedTaskListStatus: HistoryStatus.success,
            completedTasks: tasks,
          ),
        );
      },
    );
  }
}
