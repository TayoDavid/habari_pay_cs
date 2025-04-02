import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:habari_pay_cs/app.dart';
import 'package:habari_pay_cs/utils/env_config.dart';

void main() async {
  await dotenv.load(fileName: Environment.envFile);

  final app = HabariPayApp.initialize(
    baseUrl: Environment.baseUrl,
    privateKey: Environment.secretKey,
  );
  runApp(app);
}
