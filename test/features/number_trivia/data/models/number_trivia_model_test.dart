import 'dart:convert';

import 'package:flutter_number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  test(
      'should be a subclass of NumberTrivia entity',
      () async {
        final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');
        expect(tNumberTriviaModel, isA<NumberTrivia>());
      }
  );

  group('fromJson', () {
    test(
        'should return a valid model when the JSON number is an integer',
        () async {
          final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));

          final result = NumberTriviaModel.fromJson(jsonMap);
          final expected = NumberTriviaModel(
              number: 418,
              text: "418 is the error code for \"I'm a teapot\" in the Hyper Text Coffee Pot Control Protocol."
          );
          expect(result, expected);
        }
    );

    test(
        'should return a valid model when the JSON number is regarded as a double',
            () async {
          final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

          final result = NumberTriviaModel.fromJson(jsonMap);
          final expected = NumberTriviaModel(
              number: (4e+185).toInt(),
              text: "4e+185 is the number of planck volumes in the observable universe."
          );
          expect(result, expected);
        }
    );
  });
  
  group('toJson', () {
    test(
        'should return a JSON map containing the proper data',
        () async {
          final result = NumberTriviaModel(number: 1, text: 'test').toJson();
          final expected = {
            "number": 1,
            "text": 'test'
          };
          expect(result, expected);
        }
    );
  });
}