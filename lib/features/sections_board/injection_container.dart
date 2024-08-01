import 'package:dio/dio.dart';
import 'package:todolist/features/sections_board/data/datasource/section_datasource.dart';
import 'package:todolist/features/sections_board/data/repositories/section_repository.dart';
import 'package:todolist/features/sections_board/domain/repositories/section_repository.dart';
import 'package:todolist/features/sections_board/presentation/cubit/section_cubit.dart';
import 'package:todolist/injection_container.dart';

mixin SectionsInjector on Injector {
  @override
  Future<void> init() async {
    await super.init();
    final Dio dio = sl<Dio>(instanceName: globalDio);

    // cubits
    sl.registerLazySingleton<SectionCubit>(() => SectionCubit(
          sectionRepository: sl(),
        ));

    // repositories
    sl.registerLazySingleton<SectionRepository>(() => SectionRepositoryImpl(
          datasource: sl(),
        ));

    // data sources
    sl.registerLazySingleton<SectionDatasource>(
        () => SectionDatasourceImpl(dio: dio));
  }
}
