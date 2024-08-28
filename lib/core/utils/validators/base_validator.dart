import 'package:flutter/material.dart';
import 'package:notify/core/helper/snackbar.dart';

abstract class BaseValidator {
  bool validate(String value);

  String getMessage(BuildContext? context);

  static String? validateValue(
    BuildContext context,
    String value,
    List<BaseValidator> validators,
    bool isValidationActive,
  ) {
    if (!isValidationActive) return null;
    for (int i = 0; i < validators.length; i++) {
      if (!validators[i].validate(value)) {
        // ShowSnackBar.errorSnackBar(context, message);
        return validators[i].getMessage(context);
      }
    }
    return null;
  }
}
