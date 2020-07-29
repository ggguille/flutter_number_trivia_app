import 'package:dartz/dartz.dart';
import 'package:flutter_number_trivia_app/core/usecases/usecase.dart';
import 'package:flutter_number_trivia_app/core/error/failure.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCaseWithoutParams<NumberTrivia> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> call() async =>
      await this.repository.getRandomNumberTrivia();
}