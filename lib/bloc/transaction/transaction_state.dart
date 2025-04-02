part of 'transaction_bloc.dart';

class TransactionStateProps {
  final InitiateResponse? lastPaymentResponse;
  final List<TransactionDetail> transactions;
  final TransactionDetail? lastTransaction;

  TransactionStateProps({this.lastPaymentResponse, this.transactions = const [], this.lastTransaction});

  TransactionStateProps copyWith({
    InitiateResponse? initiateResponse,
    List<TransactionDetail>? newTransactions,
    TransactionDetail? transaction,
  }) {
    return TransactionStateProps(
      lastPaymentResponse: initiateResponse,
      transactions: newTransactions ?? transactions,
      lastTransaction: transaction,
    );
  }
}

sealed class TransactionState extends Equatable {
  const TransactionState(this.stateProps);

  final TransactionStateProps stateProps;

  @override
  List<Object> get props => [];
}

final class InitialTransactionState extends TransactionState {
  InitialTransactionState() : super(TransactionStateProps());
}

final class LoadingState extends TransactionState {
  final TransactionStateProps newProps;

  const LoadingState(this.newProps) : super(newProps);
}

class FailedState extends TransactionState {
  final String errMsg;
  final TransactionStateProps newProps;

  FailedState({required this.errMsg, required this.newProps}) : super(TransactionStateProps());
}

final class InitiatePaymentSuccessful extends TransactionState {
  final TransactionStateProps newProps;

  const InitiatePaymentSuccessful(this.newProps) : super(newProps);
}

final class InitiatePaymentFailed extends FailedState {
  final String err;
  final TransactionStateProps errProps;

  InitiatePaymentFailed({required this.err, required this.errProps}) : super(errMsg: err, newProps: errProps);
}

final class FetchTransByRefSuccessful extends TransactionState {
  final TransactionStateProps newProps;

  const FetchTransByRefSuccessful(this.newProps) : super(newProps);
}

final class FetchTransByRefFailed extends FailedState {
  final String err;
  final TransactionStateProps errProps;

  FetchTransByRefFailed({required this.err, required this.errProps}) : super(errMsg: err, newProps: errProps);
}

final class HistoryUpdateSuccessful extends TransactionState {
  final TransactionStateProps newProps;

  const HistoryUpdateSuccessful(this.newProps) : super(newProps);
}

final class HistoryUpdateFailed extends FailedState {
  final String err;
  final TransactionStateProps errProps;

  HistoryUpdateFailed({required this.err, required this.errProps}) : super(errMsg: err, newProps: errProps);
}

final class FetchTransHistorySuccessful extends TransactionState {
  final TransactionStateProps newProps;

  const FetchTransHistorySuccessful(this.newProps) : super(newProps);
}

final class FetchTransHistoryFailed extends FailedState {
  final String err;
  final TransactionStateProps errProps;

  FetchTransHistoryFailed({required this.err, required this.errProps}) : super(errMsg: err, newProps: errProps);
}
