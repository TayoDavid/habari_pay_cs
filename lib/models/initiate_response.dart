import 'dart:convert';

class InitiateResponse {
  final int status;
  final String message;
  final InitiateResponseData responseData;

  InitiateResponse({required this.status, required this.message, required this.responseData});

  factory InitiateResponse.fromJson(String json) => InitiateResponse.fromMap(jsonDecode(json));

  factory InitiateResponse.fromMap(Map<String, dynamic> data) {
    return InitiateResponse(
      status: data['status'],
      message: data['message'],
      responseData: InitiateResponseData.fromMap(data['data']),
    );
  }
}

class InitiateResponseData {
  final MerchantInfo merchantInfo;
  final String currency;
  final bool isRecurring;
  final String callbackUrl;
  final String transRef;
  final double transAmount;
  final List<String> authorizedChannels;
  final String checkoutUrl;
  final bool allowRecurring;

  InitiateResponseData({
    required this.merchantInfo,
    required this.currency,
    required this.isRecurring,
    required this.callbackUrl,
    required this.transRef,
    required this.transAmount,
    required this.authorizedChannels,
    required this.checkoutUrl,
    required this.allowRecurring,
  });

  factory InitiateResponseData.fromMap(Map<String, dynamic> data) {
    return InitiateResponseData(
      merchantInfo: MerchantInfo.fromMap(data['merchant_info']),
      currency: data['currency'],
      isRecurring: data['is_recurring'],
      callbackUrl: data['callback_url'],
      transRef: data['transaction_ref'],
      transAmount: data['transaction_amount'],
      authorizedChannels: (data['authorized_channels'] as List).map((item) => item as String).toList(),
      checkoutUrl: data['checkout_url'],
      allowRecurring: data['allow_recurring'],
    );
  }
}

class MerchantInfo {
  final String merchantName;
  final String merchantId;

  MerchantInfo({required this.merchantName, required this.merchantId});

  factory MerchantInfo.fromMap(Map<String, dynamic> data) {
    return MerchantInfo(
      merchantName: data['merchant_name'],
      merchantId: 'merchant_id',
    );
  }
}
