import 'package:dio/dio.dart';
import 'package:todolist/features/history/data/datasource/history_datasource.dart';
import 'package:todolist/features/history/data/repositories/history_repository.dart';
import 'package:todolist/features/history/domain/repositories/history_repository.dart';
import 'package:todolist/features/history/presentation/cubit/history_cubit.dart';
import 'package:todolist/injection_container.dart';

mixin HistoryInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    sl.registerLazySingleton<HistoryCubit>(() => HistoryCubit(
          historyRepository: sl(),
        ));

    // repositories
    sl.registerLazySingleton<HistoryRepository>(() => HistoryRepositoryImpl(
          datasource: sl(),
        ));

    // data sources
    sl.registerLazySingleton<HistoryDatasource>(
        () => HistoryDatasourceImpl(dio: dio));
  }
}
