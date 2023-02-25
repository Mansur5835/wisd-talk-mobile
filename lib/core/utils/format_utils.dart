import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

abstract class InputMasks {
  static MaskedTextController phoneNumber(String? text) =>
      MaskedTextController(mask: "+998 (00) 000 00 00", text: text)
        ..beforeChange = _phoneChanger;

  static bool _phoneChanger(String prev, String next) {
    if (next.length <= 4) return false;
    return true;
  }

  static Map<String, RegExp> _digitTranslator = {'#': RegExp(r'[0-9]')};

  static String? removePhoneOtherCharacters(String? phone) {
    if (phone == null || phone.isEmpty) return phone;
    return phone
        .replaceAll(" ", "")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("+", "")
        .replaceFirst("998", "")
        .replaceAll("-", "");
  }

  static String? removeCardOtherCharacters(String? number) {
    if (number == null || number.isEmpty) return number;
    return number.replaceAll(" ", "").replaceAll("/", "");
  }

  static formatPhoneNumber(String? phone) {
    if (phone != null && phone.length == 12 && phone.startsWith("998")) {
      return "+ 998 (${phone.substring(3, 5)}) ${phone.substring(5, 8)} ${phone.substring(8, 10)} ${phone.substring(10, 12)}";
    } else {
      return phone;
    }
  }
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 5) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 4) + '-');
      if (newValue.selection.end >= 5) selectionIndex += 3;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(4, usedSubstringIndex = 7));
      if (newValue.selection.end >= 7) selectionIndex++;
    }
    if (newTextLength >= 8) {
      newText.write('-' + newValue.text.substring(7, usedSubstringIndex = 8));
      if (newValue.selection.end >= 11) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: newText.length),
    );
  }
}
