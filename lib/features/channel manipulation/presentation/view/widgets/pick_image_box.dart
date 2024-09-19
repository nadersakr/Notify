import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/features/channel%20manipulation/presentation/controllers/channel_controller.dart';
import 'package:notify/shared/presentation/controller.dart';

class BuildChannalImageUpload extends StatefulWidget {
  const BuildChannalImageUpload({super.key});

  @override
  BuildChannalImageUploadState createState() => BuildChannalImageUploadState();
}

class BuildChannalImageUploadState extends State<BuildChannalImageUpload> {
  Future<void> _pickImage(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  try {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      final image = await decodeImageFromList(imageFile.readAsBytesSync());
      
      if (image.width / image.height > 1.2) {
        if (mounted) { // Check if the widget is still mounted
          setState(() {
            ChannelController.pickedImagePath = File(pickedFile.path);
          });
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This image is not suitable for a channel cover, please pick another image'),
            ),
          );
        }
      }
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _pickImage(context),
          child: Container(
            width: double.infinity,
            height: 150.h,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                  width: AppUIController().borderWidth,
                  color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            child: ChannelController.pickedImagePath == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.picture_frame,
                        size: 50,
                        
                        color: AppColors.primaryColor,
                      ),
                      Text(
                        'Pick channel cover',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      children: [
                        Image.file(
                          ChannelController.pickedImagePath!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Iconsax.close_square),
                            onPressed: () {
                              setState(() {
                                ChannelController.pickedImagePath = null;
                              });
                            },
                          ),
                        ),
                      ],
                    )),
          ),
        ),
      ],
    );
  }
}
