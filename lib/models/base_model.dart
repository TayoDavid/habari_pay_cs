import 'package:habari_pay_cs/utils/env_config.dart';

class BaseModel {
  String key;
  String callbackUrl;

  BaseModel()
      : key = Environment.publicKey,
        callbackUrl = Environment.callbackurl;
}
