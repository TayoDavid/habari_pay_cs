import 'package:habari_pay_cs/models/base_model.dart';

class InitiateRequest extends BaseModel {
  final double amount;
  final String email;
  final String name;
  final String currency;
  final String initiateType;

  InitiateRequest({
    required this.amount,
    required this.name,
    required this.email,
    this.currency = 'NGN',
    this.initiateType = 'inline',
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "email": email,
      "key": key,
      "currency": currency,
      "initiate_type": initiateType,
      "CallBack_URL": callbackUrl,
    };
  }
}
