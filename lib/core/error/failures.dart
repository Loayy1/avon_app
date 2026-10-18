abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = "No Internet Connection"});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = "Cache Error"});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = "Unauthorized. Please login again.", super.statusCode = 401});
}
