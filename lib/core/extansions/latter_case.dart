import 'package:flutter/services.dart';

extension CapExtension on String {
  String capitalizeSentence() {
    // Each sentence becomes an array element
    var sentences = this.split('.');
    // Initialize string as empty string
    var output = '';
    // Loop through each sentence
    for (var sen in sentences) {
      // Trim leading and trailing whitespace
      var trimmed = sen.trim();
      // Capitalize first letter of current sentence
      var capitalized = "${trimmed[0].toUpperCase() + trimmed.substring(1)}";
      // Add current sentence to output with a period
      output += capitalized + ". ";
    }
    return output;
  }
}

class CapitalCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.capitalizeSentence(),
      selection: newValue.selection,
    );
  }
}
