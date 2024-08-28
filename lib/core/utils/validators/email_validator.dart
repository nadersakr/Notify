import 'package:flutter/cupertino.dart';
import 'package:notify/core/utils/validators/base_validator.dart';

class ValiedEmail extends BaseValidator {
  @override
  String getMessage(BuildContext? context) {
    return "Email is not valid";
  }

  @override
  bool validate(String value) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }
}
