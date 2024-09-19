import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/utils/lottle/lottle.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/less_than.dart';
import 'package:notify/core/utils/validators/longer_than_chars.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/features/channel/domin/usecases/create_channel.dart';
import 'package:notify/features/channel/presentation/bloc/channel_bloc.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';
import 'package:notify/shared/domin/usecases/upload_image_usecase.dart';

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
  static resetParamters() {
    pickedColor = null;
    pickedImagePath = null;
    titleController.clear();
    descriptionController.clear();
    formKey.currentState?.reset();
  }

  ChannelController() {
    user = LoadedUserData().loadedUser;
    if (user == null) {
      // Handle the case where the user is null
      throw Exception("user is null");
      // Optionally, show an error message to the user
    }
  }

  // Toggle Privacy
  void togglePrivacy(bool value) {
    isPrivate = value;
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
      // Show CircularProgressIndicator
      RunLottleFile().showNotiftyLottle(context, "Creating Channel");

      CompressImage compressImage = sl<CompressImage>();
      CompressImageParams params = CompressImageParams(image: pickedImagePath!);
      final result = await compressImage(params);
      result.fold((l) {
        ShowSnackBar.errorSnackBar(context, l.errorMessage);
        return;
      }, (r) async {
        UploadImageParams params = UploadImageParams(image: r);
        UploadImage uploadImage = sl<UploadImage>();
        final result = await uploadImage(params);
        result.fold((l) {
          ShowSnackBar.errorSnackBar(context, l.errorMessage);
          return;
        }, (r) {
          final Channel channel = Channel(
              id: DateTime.now().microsecondsSinceEpoch,
              title: titleController.text,
              hexColor: pickedColor!.toHexString(),
              creatorId: user!.id,
              describtion: descriptionController.text,
              superVisorsId: [user!.id],
              imageUrl: r);
          CreateChannelParams params = CreateChannelParams(channel: channel);

          BlocProvider.of<ChannelBloc>(context)
              .add(CreateChannelEvent(params: params));
        });
      });
    }
  }
}
