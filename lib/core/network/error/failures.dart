import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

/// General failures
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.errorMessage, this.statusCode);
}

class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure(
    super.errorMessage,
  );
}
class ImageUtilFailure extends Failure {
  const ImageUtilFailure(
    super.errorMessage,
  );
}

/// Cancel token failure
class CacheFailure extends Failure {
  const CacheFailure(super.errorMessage);
}

class UnknowFailure extends Failure {
  const UnknowFailure(super.errorMessage);
}
class FirebaseErrorFailure extends Failure {
  const FirebaseErrorFailure(super.errorMessage);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("No internet connection");
}

