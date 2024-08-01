import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/core/interceptors/unique_request_uuid_inteceptor.dart';
import 'package:todolist/features/history/injection_container.dart';
import 'package:todolist/features/sections_board/injection_container.dart';
import 'package:todolist/features/tasks/injection_container.dart';

import 'app_config.dart';
import 'core/interceptors/error_log_interceptor.dart';
import 'core/interceptors/token_interceptor.dart';

final sl = GetIt.instance;

const globalDio = 'global';

class InjectionContainer extends Injector
    with SectionsInjector, TasksInjector, HistoryInjector {}

abstract class Injector {
  @mustCallSuper
  Future<void> init() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sl.registerLazySingleton<AppConfig>(() => AppConfig.init);

    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    sl.registerLazySingleton<Dio>(
      () {
        final dio = Dio(
          BaseOptions(
            baseUrl: sl<AppConfig>().api,
            connectTimeout: const Duration(milliseconds: 45000),
            receiveTimeout: const Duration(milliseconds: 45000),
          ),
        );
        dio.options.headers = {
          "content-type": "application/json",
          "Accept": "application/json",
        };
        dio.interceptors.add(
          ErrorLoggerInterceptor(),
        );
        dio.interceptors.add(
          TokenInterceptor(),
        );
        dio.interceptors.add(
          UUIDInterceptor(),
        );
        if (!sl<AppConfig>().isProductionEnvironment) {
          dio.interceptors.add(
            PrettyDioLogger(
              requestBody: true,
              requestHeader: true,
              responseHeader: true,
            ),
          );
        }
        return dio;
      },
      instanceName: globalDio,
    );
  }
}
