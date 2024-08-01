import 'package:dio/dio.dart';
import 'package:todolist/features/tasks/create_task/data/datasource/create_task_datasource.dart';
import 'package:todolist/features/tasks/create_task/data/repositories/create_task_repository.dart';
import 'package:todolist/features/tasks/create_task/domain/repositories/create_task_repository.dart';
import 'package:todolist/features/tasks/create_task/presentation/cubit/task_create_cubit.dart';
import 'package:todolist/features/tasks/view_task/data/datasource/view_task_datasource.dart';
import 'package:todolist/features/tasks/view_task/data/repositories/view_task_repository.dart';
import 'package:todolist/features/tasks/view_task/domain/repositories/view_task_repository.dart';
import 'package:todolist/features/tasks/view_task/presentation/cubit/view_task_cubit.dart';
import 'package:todolist/injection_container.dart';

mixin TasksInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    sl.registerLazySingleton<TaskDetailsCubit>(() => TaskDetailsCubit(
          taskDetailsRepository: sl(),
          sectionRepository: sl(),
        ));
    sl.registerLazySingleton<CreateTaskCubit>(() => CreateTaskCubit(
          taskCreateRepository: sl(),
        ));

    // repositories
    sl.registerLazySingleton<TaskDetailsRepository>(
        () => TaskDetailsRepositoryImpl(
              datasource: sl(),
            ));
    sl.registerLazySingleton<CreateTaskRepository>(
        () => CreateTaskRepositoryImpl(
              datasource: sl(),
            ));

    // data sources
    sl.registerLazySingleton<TaskDetailsDatasource>(
        () => TaskDetailsDatasourceImpl(dio: dio));
    sl.registerLazySingleton<CreateTaskDatasource>(
        () => CreateTaskDatasourceImpl(dio: dio));
  }
}
