import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/group/presentation/controllers/channal_controller.dart';
// import 'package:notify/features/group/presentation/view/widgets/fast_color_picker.dart';
import 'package:notify/features/group/presentation/view/widgets/pick_image_box.dart';
import 'package:notify/shared/domin/entities/group_model.dart';
import 'package:notify/shared/presentaion/widget/custom_button.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';
import 'package:notify/shared/presentation/controller.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen({super.key});

  @override
  CreateChannelScreenState createState() => CreateChannelScreenState();
}

class CreateChannelScreenState extends State<CreateChannelScreen> {
  // Text controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? imageUrl; // To store uploaded image URL
  int creatorId = 1; // Assume the creator ID is set elsewhere in the app
  List<int> supervisors = [];
  List<int> members = [];

  final _formKey = GlobalKey<FormState>(); // To validate the form

  // Function to create a Channel object
  void _createChannel() {
    if (_formKey.currentState?.validate() ?? false) {
      final Channel newChannel = Channel(
        id: DateTime.now().millisecondsSinceEpoch, // Generate a unique ID
        title: _titleController.text,
        describtion: _descriptionController.text,
        hexColor: "",
        creatorId: creatorId,
        superVisorsId: supervisors,
        membersId: members,
        imageUrl: imageUrl,
      );
      // Save or handle the new channel object as needed
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
                    // hintText: "Enter Title",
                    labelText: "Title",
                    textController: _titleController,
                    validator: (String? value) =>
                        controller.titleValidator(value, context),
                  ),
                  SizedBox(height: AppUIController().smallPaddingSpace),
                  // Description field
                  CustomTextFormField(
                    // hintText: "Enter Title",
                    labelText: "Description",
                    textController: _descriptionController,
                    validator: (String? value) =>
                        controller.descriptionValidator(value, context),
                  ),
                  const Spacer(),
                  // Submit button
                  ButtonWidget(
                    text: "Create Channal",
                    onPressed: _createChannel,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
