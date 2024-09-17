import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notify/core/style/app_colors.dart';

class BuildProductImageUpload extends StatefulWidget {
  const BuildProductImageUpload({super.key});

  @override
  BuildProductImageUploadState createState() => BuildProductImageUploadState();
}

class BuildProductImageUploadState extends State<BuildProductImageUpload> {
  String? selectedImagePath;

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        final image = await decodeImageFromList(imageFile.readAsBytesSync());
        print(image.width / image.height);

        // Check if the aspect ratio is approximately 1:2
        if (image.width / image.height > 1.2) {
          setState(() {
            selectedImagePath = pickedFile.path;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'this image is not suitable for a channel cover, please pick another image')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
              border: Border.all(width: 1.5.sp, color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            child: selectedImagePath == null
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
                          File(selectedImagePath!),
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
                                selectedImagePath = null;
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
