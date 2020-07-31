import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  List properties = const<dynamic>[];
  Failure(this.properties);

  @override
  List<Object> get props => properties;
}

// General failures
class ServerFailure extends Failure {
  ServerFailure(): super([]);
}

class CacheFailure extends Failure {
  CacheFailure(): super([]);
}