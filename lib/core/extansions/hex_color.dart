import 'package:flutter/material.dart';

// extension HexColor on Color {
//   /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
//   static Color fromHex(String hexString) {
//     final buffer = StringBuffer();
//     if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//     buffer.write(hexString.replaceFirst('#', ''));
//     return Color(int.parse(buffer.toString(), radix: 16));
//   }
// }

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
