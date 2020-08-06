import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {

  final List<Object> properties;

  NumberTriviaEvent(this.properties);

  @override
  List<Object> get props => this.properties;
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString): super([numberString]);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {

  GetTriviaForRandomNumber(): super([]);
}