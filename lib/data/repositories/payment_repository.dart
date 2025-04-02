import 'package:habari_pay_cs/data/data_providers/payment_data_provider.dart';
import 'package:habari_pay_cs/models/initiate_request.dart';
import 'package:habari_pay_cs/models/initiate_response.dart';
import 'package:habari_pay_cs/models/transaction_response.dart';
import 'package:tuple/tuple.dart';

class PaymentRepository {
  final PaymentDataProvider dataProvider;

  PaymentRepository({required this.dataProvider});

  Future<Tuple2<InitiateResponse?, Exception?>> initiateTransaction(InitiateRequest request) async {
    return dataProvider.initiateTransaction(request);
  }

  Future<Tuple2<TransactionDetail?, Exception?>> fetchTransactionByRef(String ref) async {
    return dataProvider.fetchTransactionByRef(ref);
  }

  Future<bool> addTransaction(TransactionDetail trans) async {
    return dataProvider.addTransaction(trans);
  }

  Future<List<TransactionDetail>> retrieveTransactions() async {
    return dataProvider.retrieveTransactions();
  }
}
