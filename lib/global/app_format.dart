import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final NumberFormat f = NumberFormat('#,###');
      final int number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final String newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length >= 9) {
      return oldValue;
    }
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final double value = double.parse(newValue.text?.replaceAll('[^\\d]', ''));
    final NumberFormat formatter = NumberFormat('#,###', 'vi_VN');

    final String newText = formatter.format(value);

    return newValue.copyWith(
        text: '$newText',
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}