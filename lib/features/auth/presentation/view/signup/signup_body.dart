import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/helper/snackbar.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/core/routers/naigator_function.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notify/features/auth/presentation/controllers/signup%20view%20model/signup_view_model.dart';
import 'package:notify/features/auth/presentation/view/widgets/signin_with_google_widget.dart';
import 'package:notify/features/auth/presentation/view/widgets/string_line_for_navigator_auth.dart';
import 'package:notify/shared/presentaion/widget/custom_button.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';
import 'package:notify/features/auth/presentation/view/widgets/password_widget.dart';

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
    // controller.usernameController = TextEditingController();
    controller.fullNameController = TextEditingController();
    controller.confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.emailController.dispose();
    controller.passwordController.dispose();
    // controller.usernameController.dispose();
    controller.fullNameController.dispose();
    controller.confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ShowSnackBar.errorSnackBar(context, state.message);
          }
          if (state is AuthSuccess) {
            // Navigator.pushReplacementNamed(
            //   context,
            //   AppRouteEnum.navMenu.name,
            // );
            navigateTo(context, AppRouteEnum.navMenu.name);
            ShowSnackBar.successSnackBar(context, "Login Success");
          }
          if (state is AuthFailure) {
            // Navigator.pushReplacementNamed(
            //   context,
            //   AppRouteEnum.homePage.name,
            // );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Loading"),
              ),
            );
          }
        },
        builder: (context, state) {
          return SizedBox(
              child: SingleChildScrollView(
                  child: Column(children: [
            SizedBox(
              height: controller.smallPaddingSpace,
            ),
            Text(
              controller.notifyString,
              style: AppTextStyle.xxxLargeBlack.copyWith(
                letterSpacing: controller.letterSpace,
              ),
            ),
            SizedBox(
              height: controller.smallPaddingSpace,
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
              height: controller.smallPaddingSpace,
            ),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: controller.widgetsWidth,
                    child: CustomTextFormField(
                      textController: controller.fullNameController,
                      validator: (String? value) =>
                          controller.nameValidator(value, context),
                      labelText: controller.fullNameLabel,
                      suffixIcon: controller.fullNameIcon,
                      hintText: controller.fullNameString,
                    ),
                  ),
                  SizedBox(
                    height: controller.smallPaddingSpace,
                  ),
                  // username textFormField
                  // SizedBox(
                  //   width: controller.widgetsWidth,
                  //   child: CustomTextFormField(
                  //     textController: controller.usernameController,
                  //     validator: (String? value) =>
                  //         controller.usernameValidator(value, context),
                  //     hintText: controller.usernameString,
                  //     labelText: controller.usernameLabel,
                  //     suffixIcon: controller.usernameIcon,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: controller.smallPaddingSpace,
                  // ),
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
                    height: controller.smallPaddingSpace,
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
                    height: controller.smallPaddingSpace,
                  ),
                  // confirm Password textFormField
                  SizedBox(
                    width: controller.widgetsWidth,
                    child: PasswordWidget(
                      textController: controller.confirmPasswordController,
                      validator: (String? value) =>
                          controller.confirmPasswordValidator(value, context,
                              controller.passwordController.text),
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
                    onPressed: () => controller.signUpWithEmail(context))),
            SizedBox(
              height: controller.smallPaddingSpace,
            ),

            // Sign in with google
            SignInWithGoogleWidget(controller: controller),
            SizedBox(
              height: controller.smallPaddingSpace,
            ),
            // Already have an account
            StringLineForSwituchAuth(controller: controller),
          ])));
        },
      ),
    );
  }
}
