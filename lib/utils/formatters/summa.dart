import 'package:flutter/services.dart';

class SummaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String txt = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    newValue = newValue.copyWith(
      text: txt,
      selection: TextSelection.collapsed(offset: txt.length),
    );
    if (txt.startsWith("0")) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    if (txt.length < 4) return newValue;

    int price = int.parse(txt);
    List<String> priceArr = [];
    while (price >= 1000) {
      var mod = price % 1000;

      if (mod < 10) {
        priceArr.add("00$mod");
      } else if (mod < 100) {
        priceArr.add("0$mod");
      } else {
        priceArr.add("$mod");
      }

      price ~/= 1000;
    }
    priceArr.add("$price");
    priceArr = priceArr.reversed.toList();
    String text = priceArr.join(" ");

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

// void main(List<String> args) {
//   // print(formatSumma(10000));

//   String price = "100";
//   price = String.fromCharCodes(price.codeUnits.reversed);
//   for (var i = 2; i < price.length - 1; i += 3) {
//     price = price.replaceRange(i, i + 1, "${price[i]} ");
//   }

//   print(String.fromCharCodes(price.codeUnits.reversed));
// }

String formatSumma(int summa) {
  String summaStr = summa.toString();
  String result = '';
  int counter = 0;
  for (int i = summaStr.length - 1; i >= 0; i--) {
    if (counter == 2) {
      result = ' ${summaStr[i]}$result';
      counter = 1;
    } else {
      result = summaStr[i] + result;
      counter++;
    }
  }
  return result.replaceAll('.', ',');
}

// TextEditingValue
