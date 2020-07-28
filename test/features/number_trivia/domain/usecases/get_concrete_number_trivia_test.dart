import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumbreTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumbreTriviaRepository mockNumbreTriviaRepository;

  setUp(() {
    mockNumbreTriviaRepository = MockNumbreTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumbreTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia for the number from the repository',
      () async {
        when(mockNumbreTriviaRepository.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        final result = await usecase(number: tNumber);

        expect(result, Right(tNumberTrivia));
        verify(mockNumbreTriviaRepository.getConcreteNumberTrivia(tNumber));
        verifyNoMoreInteractions(mockNumbreTriviaRepository);
      }
  );
}