import 'package:dartz/dartz.dart';
import 'package:todolist/core/errors/failures.dart';


typedef FutureFailable<T> = Future<Either<Failure, T>>;
typedef Failable<T> = Either<Failure, T>;
