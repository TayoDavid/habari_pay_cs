import 'package:habari_pay_cs/models/initiate_request.dart';
import 'package:habari_pay_cs/models/initiate_response.dart';
import 'package:habari_pay_cs/models/transaction_response.dart';
import 'package:habari_pay_cs/network/network_client.dart';
import 'package:habari_pay_cs/services/database_service.dart';
import 'package:habari_pay_cs/utils/app_logger.dart';
import 'package:tuple/tuple.dart';

class PaymentDataProvider with AppLogger {
  final NetworkClient client;

  PaymentDataProvider({required this.client});

  Future<Tuple2<InitiateResponse?, Exception?>> initiateTransaction(InitiateRequest request) async {
    final response = await client.post('/payment/Initiate', body: request.toJson());
    if (response.item2 == null) {
      final data = response.item1?.data;
      final result = InitiateResponse.fromMap(data);
      if (successCode.contains(result.status)) {
        return Tuple2(result, null);
      } else {
        return Tuple2(null, Exception(result.message));
      }
    } else {
      return Tuple2(null, response.item2);
    }
  }

  Future<Tuple2<TransactionDetail?, Exception?>> fetchTransactionByRef(String ref) async {
    final response = await client.get('/transaction/verify/$ref');
    if (response.item2 == null) {
      final data = response.item1?.data;
      final result = TransactionResponse.fromMap(data);
      if (successCode.contains(result.status)) {
        return Tuple2(result.responseData, null);
      } else {
        return Tuple2(null, Exception(result.message));
      }
    } else {
      return Tuple2(null, response.item2);
    }
  }

  Future<bool> addTransaction(TransactionDetail trans) async {
    return await DatabaseService.addTransaction(trans);
  }

  Future<List<TransactionDetail>> retrieveTransactions() async {
    return await DatabaseService.fetchTransactions();
  }
}
