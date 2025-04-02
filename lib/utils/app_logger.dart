import 'package:logger/logger.dart';

mixin AppLogger {
  Logger get log {
    return Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        colors: true,
        printEmojis: true,
        noBoxingByDefault: false,
      ),
    );
  }
}
