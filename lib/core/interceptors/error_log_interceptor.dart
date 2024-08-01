import 'package:dio/dio.dart';
import 'package:fimber/fimber.dart';


class ErrorLoggerInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    print(err.response);
    Fimber.e('---------------- Error Logger Interceptor ----------------');
    if (err.response == null) {
      Fimber.e('Error: no response in error - $err');
    } else {
      print(err.response!.data);
      if (err.response!.statusCode == 400) {
        final data = err.response!.data;
        if (data.isNotEmpty) {
          final keys = data.keys;
          for (final key in keys) {
            Fimber.e('$key - ${err.response!.data[key].toString()}');
          }
        } else {
          Fimber.e('Error: no body in error response - $err');
        }
      }
    }

    super.onError(err, handler);
  }
}
