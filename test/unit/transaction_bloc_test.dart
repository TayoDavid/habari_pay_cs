import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habari_pay_cs/bloc/transaction/transaction_bloc.dart';
import 'package:habari_pay_cs/data/repositories/payment_repository.dart';
import 'package:mockito/annotations.dart';

import 'transaction_bloc_test.mocks.dart';

@GenerateMocks([PaymentRepository])
void main() {
  late TransactionBloc transactionBloc;
  late MockPaymentRepository mockPaymentRepository;

  setUp(() {
    mockPaymentRepository = MockPaymentRepository();
    transactionBloc = TransactionBloc(repository: mockPaymentRepository);
  });

  tearDown(() {
    transactionBloc.close();
  });

  test('initial state is InitialTransactionState', () {
    expect(transactionBloc.state, isA<InitialTransactionState>());
  });

  blocTest<TransactionBloc, TransactionState>(
    'emits [LoadingState, FetchTransHistoryFailed] when FetchTransactionHistory is added',
    build: () => transactionBloc,
    act: (bloc) => bloc.add(FetchTransactionHistory()),
    expect: () => [
      isA<LoadingState>(),
      isA<FetchTransHistoryFailed>(),
    ],
  );
}
