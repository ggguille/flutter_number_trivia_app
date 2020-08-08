import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_number_trivia_app/core/network/network_info.dart';
import 'package:flutter_number_trivia_app/core/util/input_converter.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:flutter_number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.asNewInstance();

Future<void> init() async {
  //! Features - Number Trivia
  //Bloc
  sl.registerFactory(
          () => NumberTriviaBloc(
            concrete: sl(),
            random: sl(),
            inputConverter: sl()
          )
  );
  // Use Cases
  sl.registerLazySingleton(() => GetTriviaForConcreteNumber(sl()));
  sl.registerLazySingleton(() => GetTriviaForRandomNumber());
  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
          () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          )
  );
  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
        () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
        () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}