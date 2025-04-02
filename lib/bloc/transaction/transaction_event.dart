part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  Future<void> handle(TransactionBloc bloc, Emitter emit);

  @override
  List<Object?> get props => [];
}

class InitiateTransaction extends TransactionEvent {
  final InitiateRequest request;

  InitiateTransaction({required this.request});

  @override
  Future<void> handle(TransactionBloc bloc, Emitter emit) async {
    final stateProps = bloc.state.stateProps;
    emit(LoadingState(stateProps));
    try {
      final result = await bloc.repository.initiateTransaction(request);
      final resultData = result.item1;
      final exception = result.item2;
      if (resultData != null) {
        final newStateProps = stateProps.copyWith(initiateResponse: resultData);
        emit(InitiatePaymentSuccessful(newStateProps));
      } else if (exception is DioException) {
        emit(InitiatePaymentFailed(err: exception.message.value, errProps: stateProps));
      } else {
        debugPrint(exception.toString());
        emit(InitiatePaymentFailed(err: 'Something went wrong!', errProps: stateProps));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(InitiatePaymentFailed(err: 'Something went wrong!', errProps: stateProps));
    }
  }
}

class FetchTransactionByRef extends TransactionEvent {
  final String ref;

  FetchTransactionByRef({required this.ref});

  @override
  Future<void> handle(TransactionBloc bloc, Emitter emit) async {
    final stateProps = bloc.state.stateProps;
    emit(LoadingState(stateProps));
    try {
      final response = await bloc.repository.fetchTransactionByRef(ref);
      final transaction = response.item1;
      final exception = response.item2;
      if (transaction != null) {
        emit(FetchTransByRefSuccessful(stateProps.copyWith(transaction: transaction)));
      } else if (exception is DioException) {
        emit(FetchTransByRefFailed(err: exception.message.value, errProps: stateProps));
      } else {
        emit(FetchTransByRefFailed(err: 'Something went wrong', errProps: stateProps));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(FetchTransByRefFailed(err: 'Something went wrong', errProps: stateProps));
    }
  }
}

class UpdateTransactionsHistory extends TransactionEvent {
  @override
  Future<void> handle(TransactionBloc bloc, Emitter emit) async {
    final stateProps = bloc.state.stateProps;
    final lastTransaction = stateProps.lastTransaction;
    debugPrint("last transaction: \n${lastTransaction?.toMap()}");
    emit(LoadingState(stateProps));
    if (lastTransaction != null) {
      final success = await bloc.repository.addTransaction(lastTransaction);
      if (success) {
        emit(HistoryUpdateSuccessful(stateProps.copyWith(transaction: null)));
      } else {
        emit(HistoryUpdateFailed(
          err: 'Error updating transactions',
          errProps: stateProps.copyWith(transaction: null),
        ));
      }
    } else {
      emit(HistoryUpdateFailed(
        err: 'No transaction found!',
        errProps: stateProps.copyWith(transaction: null),
      ));
    }
  }
}

class FetchTransactionHistory extends TransactionEvent {
  @override
  Future<void> handle(TransactionBloc bloc, Emitter emit) async {
    final stateProps = bloc.state.stateProps;
    emit(LoadingState(stateProps));
    try {
      final transactions = await bloc.repository.retrieveTransactions();

      transactions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      final newProps = stateProps.copyWith(newTransactions: transactions);
      emit(FetchTransHistorySuccessful(newProps));
    } catch (e) {
      debugPrint(e.toString());
      emit(FetchTransHistoryFailed(err: 'Error fetching transactions', errProps: stateProps));
    }
  }
}
