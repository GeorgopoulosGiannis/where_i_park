abstract class Failure {
  final String message;
  final int code;

  Failure(
    this.message,
    this.code,
  );
}

class ServerFailure extends Failure {
  ServerFailure({
    required message,
    required code,
  }) : super(
          message,
          code,
        );
}