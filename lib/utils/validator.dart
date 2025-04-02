class Validator {
  static String? isValidInput(String? input) {
    if (input == null || input.isEmpty) return 'Field is required';
    return null;
  }

  static String? isValidAmount(String? amount) {
    if (amount == null || amount.isEmpty) return 'Amount field is required';
    final amt = double.tryParse(amount);
    if (amt == null || amt < 100.0) return 'Amount can not be less than 100';
    return null;
  }

  static String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email field is required';

    // Regular expression for email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );

    return emailRegex.hasMatch(email) ? null : 'Invalid email address';
  }
}
