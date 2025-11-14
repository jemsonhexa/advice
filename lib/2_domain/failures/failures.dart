abstract class Failure {
  final String message;
  const Failure([this.message = 'An unknown error occurred']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Failure']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache Failure']);
}

class GeneralFailure extends Failure {
  const GeneralFailure([super.message = 'Unexpected Failure']);
}
