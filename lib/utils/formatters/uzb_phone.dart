import 'package:flutter/services.dart';

class UzbekPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    newValue = newValue.copyWith(text: newValue.text.replaceAll(RegExp(r'[^\d,-]'), ''));
    if (newValue.text.length > 11) {
      return oldValue;
    }
    if (newValue.text.length < 2 || oldValue.text.length > newValue.text.length) {
      return newValue;
    } else {
      if (newValue.text.length == 2 || newValue.text.length == 6) {
        return TextEditingValue(
          text: "${newValue.text}-",
          selection: TextSelection.collapsed(offset: newValue.text.length + 1),
        );
      }
    }

    return TextEditingValue(
      text: newValue.text,
      selection: TextSelection.collapsed(offset: newValue.text.length),
    );
  }
}
