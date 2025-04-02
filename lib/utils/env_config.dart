import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static get envFile => '.env.development';
  static get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static get publicKey => dotenv.env['PUBLIC_KEY'] ?? '';
  static get secretKey => dotenv.env['PRIVATE_KEY'] ?? '';
  static get callbackurl => dotenv.env['CALLBACK_URL'] ?? '';
}
