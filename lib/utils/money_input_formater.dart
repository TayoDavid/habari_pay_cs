import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:habari_pay_cs/utils/extension.dart';

class MoneyInputFormatter extends TextInputFormatter {
  // Regular expression to match digits and a decimal point
  static final _regExp = RegExp(r'(\d+)(\.?)(\d{0,2})');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-numeric characters from the input
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Use the regular expression to format the text with commas and decimal points
    RegExpMatch? match = _regExp.firstMatch(cleanedText);
    String formattedText = '';
    if (match != null) {
      String wholeNumberPart = match.group(1).value;
      String decimalPart = match.group(3).value;
      formattedText = NumberFormat('#,###,###,##0').format(int.parse(wholeNumberPart));
      if (decimalPart.isNotEmpty) {
        formattedText += '.${decimalPart.padRight(2, '0')}';
      }
    }

    // Calculate the selection index after formatting
    int selectionIndex = newValue.selection.end + formattedText.length - cleanedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
