import 'package:flutter/material.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/less_than.dart';
import 'package:notify/core/utils/validators/longer_than_chars.dart';
import 'package:notify/core/utils/validators/required_validator.dart';

class ChannalController {
 static List<String> pickedImagePaths = [];
  String? titleValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        (value ?? "").trim(),
        [RequiredValidator(), LognerThanChars(2), LessThanChars(20)],
        true,
      );
  String? descriptionValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LognerThanChars(6), LessThanChars(40)],
        true,
      );
}
