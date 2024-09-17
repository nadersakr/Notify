import 'package:flutter/material.dart';
import 'base_validator.dart';

class LognerThanChars extends BaseValidator {
  final int charCount;
  LognerThanChars(this.charCount);

  @override
  String getMessage(BuildContext? context) {
    return "Field must be longer than $charCount characters";
  }

  @override
  bool validate(String value) {
    return value.length > charCount;
  }
}
