import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/group/presentation/controllers/channal_controller.dart';
// import 'package:notify/features/group/presentation/view/widgets/fast_color_picker.dart';
import 'package:notify/features/group/presentation/view/widgets/pick_image_box.dart';
import 'package:notify/shared/domin/entities/group_model.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/presentaion/widget/custom_button.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';
import 'package:notify/shared/presentation/controller.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen({super.key});

  @override
  CreateChannelScreenState createState() => CreateChannelScreenState();
}

class CreateChannelScreenState extends State<CreateChannelScreen> {
  UserModel user = LoadedUserData().loadedUser!;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? imageUrl;
  final _formKey = GlobalKey<FormState>();
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  bool _isPrivate = false; // Add this line

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  // Function to create a Channel object
  Future<void> _createChannel() async {
    if (ChannalController.pickedImagePath == null) {
      ShowSnackBar.errorSnackBar(context, "Pick channal cover");
      return;
    }
    final compressedImage = await FlutterImageCompress.compressWithFile(
      ChannalController.pickedImagePath!.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    if (compressedImage == null) {
      ShowSnackBar.errorSnackBar(context, "Image compression failed.");
      return;
    }
    print(compressedImage);
    if (_formKey.currentState?.validate() ?? false) {
      final Channel newChannel = Channel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        describtion: _descriptionController.text,
        hexColor: "",
        creatorId: user.id,
        superVisorsId: [],
        membersId: [],
        imageUrl: imageUrl,
        isPrivate: _isPrivate, // Add this line
      );
      print(newChannel);
    }
  }

  @override
  Widget build(BuildContext context) {
    ChannalController controller = ChannalController();
    return Align(
      alignment: Alignment.center,
      child: SafeArea(
        child: SizedBox(
          width: AppUIController().widgetsWidth,
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppUIController().smallPaddingSpace),
                    Text(
                      'Create New Channel',
                      style: AppTextStyle.xLargeBlack
                          .copyWith(letterSpacing: 1.5.sp),
                    ),
                    SizedBox(height: AppUIController().smallPaddingSpace),
                    const BuildProductImageUpload(),
                    SizedBox(height: AppUIController().smallPaddingSpace),
                    // Title field
                    CustomTextFormField(
                      maxLenght: 19,
                      labelText: "Title",
                      textController: _titleController,
                      validator: (String? value) =>
                          controller.titleValidator(value, context),
                    ),
                    SizedBox(height: AppUIController().smallPaddingSpace),
                    // Description field
                    CustomTextFormField(
                      maxLines: 3,
                      maxLenght: 39,
                      labelText: "Description",
                      textController: _descriptionController,
                      validator: (String? value) =>
                          controller.descriptionValidator(value, context),
                    ),
                    SizedBox(height: AppUIController().smallPaddingSpace),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              builder: (context) => AlertDialog(
                                title: const Text('Pick a color!'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: changeColor,
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Got it'),
                                    onPressed: () {
                                      setState(
                                          () => currentColor = pickerColor);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                              context: context,
                            );
                          },
                          child: Container(
                              height: 45.h,
                              width: AppUIController().widgetsWidth -
                                  45.h -
                                  AppUIController().smallPaddingSpace,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.sp)),
                                  border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 1.5.sp)),
                              child: const Center(
                                  child: Text("Pick Channal Color"))),
                        ),
                        SizedBox(width: AppUIController().smallPaddingSpace),
                        Container(
                          width: 45.h,
                          height: 45.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: currentColor, width: 3.sp)),
                        )
                      ],
                    ),
                    // Add the Switch for isPrivate
                    SizedBox(height: 0.5 * AppUIController().smallPaddingSpace),
                    SwitchListTile(
                      contentPadding: const EdgeInsets.all(0),
                      activeColor: AppColors.primaryColor,
                      inactiveTrackColor:
                          AppColors.primaryColor.withOpacity(0.5),
                      inactiveThumbColor: AppColors.white,
                      title: const Text('Private Channel'),
                      value: _isPrivate,
                      onChanged: (bool value) {
                        setState(() {
                          _isPrivate = value;
                        });
                      },
                    ),
                    SizedBox(height: AppUIController().smallPaddingSpace),
                    ButtonWidget(
                      text: "Create Channal",
                      onPressed: _createChannel,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
