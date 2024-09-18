import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/less_than.dart';
import 'package:notify/core/utils/validators/longer_than_chars.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class ChannelController {
  static Color? pickedColor;
  static File? pickedImagePath;
  static final TextEditingController titleController = TextEditingController();
  static final TextEditingController descriptionController =
      TextEditingController();
  static final formKey = GlobalKey<FormState>();
  static bool isPrivate = false;
  static String imageUri = "";
  UserModel? user;

  ChannelController() {
    user = LoadedUserData().loadedUser;
    if (user == null) {
      // Handle the case where the user is null
      print("Error: Loaded user is null");
      // Optionally, show an error message to the user
    }
  }

  // Toggle Privacy
  void togglePrivacy(bool value) {
    isPrivate = value;
    print(isPrivate);
  }

  // Validation
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

  // Create Channel Logic
  Future<void> createChannel(BuildContext context) async {
    if (formKey.currentState!.validate()) {
    } else {
      ShowSnackBar.errorSnackBar(
          context, "Please fill in all required fields.");
      return;
    }
    if (pickedColor == null) {
      ShowSnackBar.errorSnackBar(context, "Pick channel color");
      return;
    }

    if (pickedImagePath == null) {
      ShowSnackBar.errorSnackBar(context, "Pick channel cover");
      return;
    }

    if (user == null) {
      ShowSnackBar.errorSnackBar(context, "User data is not loaded.");
      return;
    }

    final compressedImage = await FlutterImageCompress.compressWithFile(
      pickedImagePath!.absolute.path,
      minWidth: 600,
      minHeight: 500,
      quality: 75,
    );

    if (compressedImage == null) {
      ShowSnackBar.errorSnackBar(context, "Image compression failed.");
      return;
    }

    final compressedImageFile = File(
      '${pickedImagePath!.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await compressedImageFile.writeAsBytes(compressedImage);

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('uploads/${compressedImageFile.uri.pathSegments.last}');
      await storageRef.putFile(compressedImageFile);
      imageUri = await storageRef.getDownloadURL();
    } catch (e) {
      print("Error during image upload: $e");
      ShowSnackBar.errorSnackBar(context, "Error uploading image: $e");
      return;
    }
    print("Successfully uploaded image");
    print(
        'Creating channel with details: ${titleController.text}, ${descriptionController.text}, private: $isPrivate, color: ${pickedColor!.toHexString()},image: $imageUri');
  }
}
