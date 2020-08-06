import 'package:equatable/equatable.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaState extends Equatable {

  final List<Object> properties;

  NumberTriviaState(this.properties);

  @override
  List<Object> get props => this.properties;
}

class Empty extends NumberTriviaState {

  Empty(): super([]);
}

class Loading extends NumberTriviaState {

  Loading(): super([]);
}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia}) : super([trivia]);
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message}) : super([message]);
}