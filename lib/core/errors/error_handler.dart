import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todolist/core/errors/server_error.dart';
import 'failures.dart';

Future<Failure> errorHandler(Object error, Failure? defaultFailure) async {
  try {
    if (error is DioError) {
      if (error.response != null) {
        if (error.response!.statusCode == 403) {
          return ForbiddenFailure(
            errorMap: error.response!.data,
          );
        } else if (error.response!.statusCode == 401) {
          return UnauthorizedFailure(
            errorMap: error.response!.data,
          );
        } else if (error.response!.statusCode == 308) {
          return PermanentRedirect(
            errorMap: error.response!.data,
          );
        } else if (error.response!.statusCode == 403 &&
            defaultFailure is ProfileFailure) {
          return UnauthorizedFailure();
        } else if (error.response!.statusCode == 422) {
          return UnprocessableEntityFailure(
            errorMessage: error.response!.data['message'],
            errorCode: error.response?.statusCode ?? 0,
          );
        } else if (error.response!.statusCode == 429) {
          return TooManyRequestsFailure(
            errorMessage: error.response!.data['message'] ?? "",
            errorCode: error.response?.statusCode ?? 0,
          );
        } else if (error.response!.statusCode == 404) {
          return NotFoundFailure();
        } else if (error.response!.statusCode == 400) {
          return BadRequestFailure(
            errorMap: error.response!.data,
            errorMessage: error.response!.data['message'] ?? "",
            errorCode: error.response?.statusCode ?? 0,
          );
        } else if (error.response!.statusCode == 402) {
          return ExceededDailySearchLimit(
            errorMap: error.response!.data,
            errorMessage: error.response!.data['message'] ?? error.response!.data['detail'] ?? "",
            errorCode: error.response?.statusCode ?? 0,
          );
        }
        ServerError serverError =
        ServerError.fromJson(error.response?.data ?? {});
        return Failure(
            errorMessage: serverError.detail != null &&
                serverError.detail!.isNotEmpty
                ? serverError.detail!
                : "Sorry, we cannot process your request at the moment. Please contact the support team.");
      } else if (error.type == DioErrorType.unknown &&
          error.error is SocketException) {
        return NoInternetFailure();
      } else if (error.type == DioErrorType.connectionTimeout ||
          error.type == DioErrorType.receiveTimeout) {
        return ConnectionTimeoutFailure();
      }
    } else if (error is TimeoutException) {
      return RepositoryTimeoutFailure();
    }

    return defaultFailure!;
  } catch (err) {
    return Failure();
  }
}
