import 'package:meta/meta.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({
      @required int number,
      @required String text
  }) : super(number: number, text: text);
}