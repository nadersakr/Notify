import 'package:flutter/material.dart';
import 'base_validator.dart';

class NoSpaceValidator extends BaseValidator {
  @override
  String getMessage(BuildContext? context) {
    return "remove spaces";
  }

  @override
  bool validate(String value) {
    return !value.trim().contains(" ");
  }
}
