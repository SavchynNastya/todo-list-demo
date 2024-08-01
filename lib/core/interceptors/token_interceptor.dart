import 'package:dio/dio.dart';
import 'package:todolist/app_config.dart';
import 'package:todolist/injection_container.dart';


class TokenInterceptor extends Interceptor {
  TokenInterceptor();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = sl<AppConfig>().todoistApiKey;

    if (options.headers.containsKey('Authorization')) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    super.onRequest(options, handler);
  }
}
