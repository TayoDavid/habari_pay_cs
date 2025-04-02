import 'package:intl/intl.dart';

/// [String?] extensions
extension StringOptionalExt on String? {
  String get value => this ?? '';
}

extension StringExt on String {
  String get moneyFormat {
    return double.parse(this).toStringAsFixed(2);
  }
}

/// [DateTime] extensions
extension DateExtensions on DateTime {
  String formated() {
    DateFormat formatter = DateFormat('dd MMM, yyyy');
    return formatter.format(this);
  }

  String fullWordedDate() {
    DateFormat formatter = DateFormat('EEE dd MMMM yyyy, hh:mm aaa');
    return formatter.format(this);
  }
}
