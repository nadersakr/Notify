import 'package:flutter/material.dart';
import 'base_validator.dart';

class LessThanChars extends BaseValidator {
  final int length;
  LessThanChars(this.length);
  @override
  String getMessage(BuildContext? context) {
    return "Password must be less than $length characters";
  }

  @override
  bool validate(String value) {
    return value.length < length;
  }
}
