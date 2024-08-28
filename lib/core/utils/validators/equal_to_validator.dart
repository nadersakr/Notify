import 'package:flutter/material.dart';
import 'package:notify/core/utils/validators/base_validator.dart';

class EqualToPasswordValidator extends BaseValidator {
  final String text;
  EqualToPasswordValidator(this.text);
    
  @override
  String getMessage(BuildContext? context) {
    return "it does not match";
  }
  
  @override
  bool validate(String value) {
    return value == text;
  }
}