import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/features/group/presentation/controllers/channal_controller.dart';
import 'package:notify/shared/presentation/controller.dart';

class ChannelColorPicker extends StatefulWidget {
  const ChannelColorPicker({super.key});

  @override
  ChannelColorPickerState createState() => ChannelColorPickerState();
}

class ChannelColorPickerState extends State<ChannelColorPicker> {
  Color pickerColor = Colors.black;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    ChannalController.pickedColor ??= Colors.black;  // Ensure pickedColor is initialized
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
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
                      setState(() {
                        ChannalController.pickedColor = pickerColor;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
          child: Container(
            height: 45.h,
            width: AppUIController().widgetsWidth - 
                45.h - 
                AppUIController().smallPaddingSpace,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.sp)),
              border: Border.all(color: AppColors.primaryColor, width: 1.5.sp),
            ),
            child: const Center(child: Text("Pick Channel Color")),
          ),
        ),
        SizedBox(width: AppUIController().smallPaddingSpace),
        Container(
          width: 45.h,
          height: 45.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ChannalController.pickedColor!,  // Safe usage after initialization
              width: 8.sp,
            ),
          ),
        ),
      ],
    );
  }
}
