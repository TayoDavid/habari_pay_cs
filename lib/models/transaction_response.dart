class TransactionResponse {
  final int status;
  final String message;
  final TransactionDetail responseData;

  TransactionResponse({
    required this.status,
    required this.message,
    required this.responseData,
  });

  factory TransactionResponse.fromMap(Map<String, dynamic> data) {
    return TransactionResponse(
      status: data['status'],
      message: data['message'],
      responseData: TransactionDetail.fromMap(data['data']),
    );
  }
}

class TransactionDetail {
  final num transactionAmount;
  final String transRef;
  final String email;
  final String status;
  final String currencyId;
  final DateTime? createdAt;
  final String transactionType;
  final String merchantName;
  final String merchantBusinessName;
  final String gatewayTransRef;
  final String merchantEmail;
  final num fee;
  final num merchantAmount;

  TransactionDetail({
    required this.transactionAmount,
    required this.transRef,
    required this.email,
    required this.status,
    required this.currencyId,
    required this.createdAt,
    required this.transactionType,
    required this.merchantName,
    required this.merchantBusinessName,
    required this.gatewayTransRef,
    required this.merchantEmail,
    required this.fee,
    required this.merchantAmount,
  });

  factory TransactionDetail.fromMap(Map<String, dynamic> data) {
    return TransactionDetail(
      transactionAmount: data['transaction_amount'],
      transRef: data['transaction_ref'],
      email: data['email'],
      status: data['transaction_status'],
      currencyId: data['transaction_currency_id'],
      createdAt: DateTime.tryParse(data['created_at']),
      transactionType: data['transaction_type'],
      merchantName: data['merchant_name'],
      merchantBusinessName: data['merchant_business_name'],
      gatewayTransRef: data['gateway_transaction_ref'],
      merchantEmail: data['merchant_email'],
      fee: data['fee'],
      merchantAmount: data['merchant_amount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transaction_amount': transactionAmount,
      'transaction_ref': transRef,
      'email': email,
      'transaction_status': status,
      'transaction_currency_id': currencyId,
      'created_at': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'transaction_type': transactionType,
      'merchant_name': merchantName,
      'merchant_business_name': merchantBusinessName,
      'gateway_transaction_ref': gatewayTransRef,
      'merchant_email': merchantEmail,
      'fee': fee,
      'merchant_amount': merchantAmount,
    };
  }
}
