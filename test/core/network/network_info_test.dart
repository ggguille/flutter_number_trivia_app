import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_number_trivia_app/core/network/network_info.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
        'should forward the call to DataConnectionChecker.hasConnection',
        () async {
          final tHasConnectionFuture = Future.value(true);

          when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((realInvocation) => tHasConnectionFuture);

          final result = networkInfo.isConnected;

          verify(mockDataConnectionChecker.hasConnection);
          expect(result, tHasConnectionFuture);
        }
    );
  });
}