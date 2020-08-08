import 'package:flutter_number_trivia_app/core/error/failure.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia_app/core/util/input_converter.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  static final NumberTriviaState _initialState = Empty();

  NumberTriviaBloc({
      @required GetConcreteNumberTrivia concrete,
      @required GetRandomNumberTrivia random,
      @required this.inputConverter
  }) : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(_initialState);

  NumberTriviaState get initialState => _initialState;

  @override
  Stream<NumberTriviaState> mapEventToState(
      NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
            (failure) async* {
              yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
            },
            (integer) async* {
              yield Loading();
              final failureOrTrivia = await getConcreteNumberTrivia(
                  Params(number: integer)
              );
              yield failureOrTrivia.fold(
                      (failure) => Error(message: _mapFailureToMessage(failure)),
                      (trivia) => Loaded(trivia: trivia)
              );
            },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch(failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}