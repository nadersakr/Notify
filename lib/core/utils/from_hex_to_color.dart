import 'package:flutter/material.dart';

class FromHexToColor {
  static Color getColor(String hexColor) => Color(int.parse('0xFF$hexColor'));
}
