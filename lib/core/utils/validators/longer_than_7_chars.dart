

import 'package:flutter/material.dart';
import 'base_validator.dart';

class LognerThan7Chars extends BaseValidator {
  @override
  String getMessage(BuildContext? context) {
    return "Password must be longer than 7 characters";
  }

  @override
  bool validate(String value) {
    return value.length > 7;
  }
}


