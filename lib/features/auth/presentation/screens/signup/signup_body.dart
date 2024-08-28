import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/auth/presentation/screens/view%20model/signup%20view%20model/signup_view_model.dart';
import 'package:notify/features/auth/presentation/widgets/signin_with_google_widget.dart';
import 'package:notify/features/auth/presentation/widgets/string_line_for_navigator_auth.dart';
import 'package:notify/shared/presentaion/widget/custom_button.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';
import 'package:notify/features/auth/presentation/widgets/password_widget.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  SignupViewModle controller = SignupViewModle();
  @override
  void initState() {
    super.initState();
    controller.emailController = TextEditingController();
    controller.passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.emailController.dispose();
    controller.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: SingleChildScrollView(
            child: Column(children: [
      SizedBox(
        height: controller.paddingSpace,
      ),
      Text(
        controller.notifyString,
        style: AppTextStyle.xxxLargeBlack.copyWith(
          letterSpacing: controller.letterSpace,
        ),
      ),
      SizedBox(
        height: controller.paddingSpace,
      ),
      SizedBox(
        width: controller.widgetsWidth,
        child: Text(
          controller.headLine,
          style: AppTextStyle.largeBlack,
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        height: controller.paddingSpace,
      ),
      Form(
        key: controller.formKey,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: (1.sw - controller.widgetsWidth) / 2,
                ),
                // First name textFormField
                SizedBox(
                  width: (controller.widgetsWidth / 2) -
                      controller.paddingSpace / 2,
                  child: CustomTextFormField(
                    validator: (String? value) =>
                        controller.nameValidator(value, context),
                    labelText: controller.firstNameLabel,
                    suffixIcon: controller.firstNameIcon,
                  ),
                ),
                SizedBox(
                  width: controller.paddingSpace,
                ),
                // Last name textFormField
                SizedBox(
                  width: (controller.widgetsWidth / 2) -
                      controller.paddingSpace / 2,
                  child: CustomTextFormField(
                    validator: (String? value) =>
                        controller.nameValidator(value, context),
                    labelText: controller.lastNameLabel,
                    suffixIcon: controller.lastNameIcon,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: controller.paddingSpace,
            ),
            // username textFormField
            SizedBox(
              width: controller.widgetsWidth,
              child: CustomTextFormField(
                hintText: controller.usernameString,
                labelText: controller.usernameLabel,
                suffixIcon: controller.usernameIcon,
              ),
            ),
            SizedBox(
              height: controller.paddingSpace,
            ),
            // email textFormField
            SizedBox(
              width: controller.widgetsWidth,
              child: CustomTextFormField(
                textController: controller.emailController,
                validator: (String? value) =>
                    controller.emailValidator(value, context),
                hintText: controller.emailString,
                labelText: controller.emailLabel,
                suffixIcon: controller.emailIcon,
              ),
            ),
            SizedBox(
              height: controller.paddingSpace,
            ),
            // password textFormField
            SizedBox(
              width: controller.widgetsWidth,
              child: PasswordWidget(
                  textController: controller.passwordController,
                  validator: (String? value) =>
                      controller.passwordValidator(value, context),
                  controller: controller),
            ),
            SizedBox(
              height: controller.paddingSpace,
            ),
            // confirm Password textFormField
            SizedBox(
              width: controller.widgetsWidth,
              child: PasswordWidget(
                controller: controller,
                isConfirmPassword: true,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: controller.largepaddingSpace,
      ),
      // Signup button
      SizedBox(
          width: controller.widgetsWidth,
          child: ButtonWidget(
              text: controller.signupString,
              onPressed: controller.signUpWithEmail)),
      SizedBox(
        height: controller.paddingSpace,
      ),

      // Sign in with google
      SignInWithGoogleWidget(controller: controller),
      SizedBox(
        height: controller.paddingSpace,
      ),
      // Already have an account
      StringLineForSwituchAuth(controller: controller),
    ])));
  }
}
