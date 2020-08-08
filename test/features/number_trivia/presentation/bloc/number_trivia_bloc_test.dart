import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_app/core/error/failure.dart';
import 'package:flutter_number_trivia_app/core/util/input_converter.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() async {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    // The event takes in a String
    final tNumberString = '1';
    // This is the successful output of the InputConverter
    final tNumberParsed = int.parse(tNumberString);
    // NumberTrivia instance is needed too, of course
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));
    void setUpMockGetConcreteNumberTriviaSuccess() =>
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

    blocTest(
        'should emit [Error] when the input is invalid',
        build: () {
          when(mockInputConverter.stringToUnsignedInteger(any))
              .thenReturn(Left(InvalidInputFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
        expect: [Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
    );

    test(
        'should get data from the concrete use case',
        () async {
          setUpMockInputConverterSuccess();
          setUpMockGetConcreteNumberTriviaSuccess();

          bloc.add(GetTriviaForConcreteNumber(tNumberString));
          await untilCalled(mockGetConcreteNumberTrivia(any));

          verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
        }
    );

    blocTest(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: [
        Loading(),
        Loaded(trivia: tNumberTrivia)
      ],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ],
    );
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    test(
      'should get data from the random use case',
          () async {
        // arrange
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia());
        // assert
        verify(mockGetRandomNumberTrivia());
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Right(tNumberTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: [
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      build: () {
        when(mockGetRandomNumberTrivia())
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ],
    );
  });
}

