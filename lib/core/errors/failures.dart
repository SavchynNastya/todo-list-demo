import 'package:equatable/equatable.dart';
import 'package:todolist/core/errors/error_model.dart';


class Failure extends Equatable {
  @override
  List<Object> get props => [];

  final String? errorMessage;
  final List<ErrorModel>? errorData;
  final int? errorCode;
  final Map<String, dynamic>? errorMap;

  Failure({
    this.errorMessage = 'Unexpected error occurred',
    this.errorCode,
    this.errorData,
    this.errorMap,
  });

  @override
  String toString() {
    return "Failure(errorMessage: $errorMessage, errorData $errorData, errorCode: $errorCode)";
  }
}

// General failures
class InternetConnectionFailure extends Failure {}

class NoInternetFailure extends InternetConnectionFailure {}

class ConnectionTimeoutFailure extends InternetConnectionFailure {}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NotFoundFailure extends Failure {}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({
    super.errorMap,
  });
}

class ProfileFailure extends Failure {}

class UnprocessableEntityFailure extends Failure {
  UnprocessableEntityFailure({
    super.errorMessage,
    super.errorCode,
    super.errorData,
  });
}

class BadRequestFailure extends Failure {
  BadRequestFailure({
    super.errorMessage,
    super.errorCode,
    super.errorMap,
  });
}

class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure({
    super.errorMessage,
    super.errorCode,
    super.errorMap,
  });
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure({
    super.errorMessage,
    super.errorCode,
    super.errorMap,
  });
}

class ExceededDailySearchLimit extends Failure {
  ExceededDailySearchLimit({
    super.errorMessage,
    super.errorCode,
    super.errorMap,
  });
}

class PermanentRedirect extends Failure {
  PermanentRedirect({
    super.errorMessage,
    super.errorCode,
    super.errorMap,
  });
}

class RepositoryTimeoutFailure extends Failure {}
