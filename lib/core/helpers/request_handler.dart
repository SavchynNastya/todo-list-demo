
import 'package:dartz/dartz.dart';
import 'package:todolist/core/errors/error_handler.dart';
import 'package:todolist/core/errors/failures.dart';
import 'package:todolist/core/helpers/types.dart';


class RepositoryRequestHandler<T> {
  FutureFailable<T> call({
    Failure? defaultFailure,
    required Future<T> Function() request,
  }) async {
    try {
      return Right(await request());
    } catch (error) {
      final failure = await errorHandler(error, defaultFailure);
      return Left(failure);
    }
  }
}
