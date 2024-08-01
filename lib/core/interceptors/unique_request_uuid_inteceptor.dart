import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';


class UUIDInterceptor extends Interceptor {
  UUIDInterceptor();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final uuid = const Uuid().v4();

    if (options.headers.containsKey('X-Request-Id')) {
      options.headers['X-Request-Id'] = uuid;
    } else {
      options.headers.putIfAbsent('X-Request-Id', () => uuid);
    }

    super.onRequest(options, handler);
  }
}
