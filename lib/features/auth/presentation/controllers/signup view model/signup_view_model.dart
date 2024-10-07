import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/core/routers/naigator_function.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/equal_to_validator.dart';
import 'package:notify/core/utils/validators/longer_than_chars.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
import 'package:notify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notify/features/auth/presentation/controllers/auth_view_model.dart';
import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';

class SignupViewModle extends AuthViewModel
    with Icons, Strings, Sizes, Validators {
  // variables
  String? selectedImage;
  // error messages
  static String weakPassword = "Password is too weak";
  static String defaultError = "There is an error on Authentication";
  static String emailAlreadyInUse = "This email is already in use";
  static String invalidEmail = "Email is not valid";
  static String userNotFound = "User not found";
  static String userNotCreated = "User not created";
  static String userDataNotFound = "User data not found";
  static String userDatadidnotSaved = "User's data did not saved";
  @override
  String get stringGoTo => "Login";

  @override
  Function(BuildContext context) get navigatotGoTO => (BuildContext context) {
        // Navigator.pushReplacementNamed(
        //   context,
        //   AppRouteEnum.loginPage.name,
        // );
        navigateTo(context, AppRouteEnum.loginPage.name);
      };

  @override
  String get donothaveAccountString => "Already have an account?";
  pickImage(BuildContext context) async {
    // Implement the image picker functionality here
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    selectedImage = image?.path;
    print(selectedImage);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  // late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  Future<void> signUpWithEmail(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      //  for testing
      // print("email : ${emailController.text.toLowerCase().trim()}");
      // print("password : ${passwordController.text}");
      // print("first name : ${firstNameController.text}");
      // print("last name : ${lastNameController.text}");
      // print("username : ${usernameController.text}");
      // print("confirm password : ${confirmPasswordController.text}");
      // SharedPreferences sharedPreferncesServices =
      //     await SharedPreferences.getInstance();

      // SharedPreferencesServices sharedPreferencesServices =
      //     SharedPreferencesServices(
      //         sharedPreferences: sharedPreferncesServices);
      // AuthLocalDataSource authLocalDataSourceImpl = AuthLocalDataSourceImp(
      //     saveDataLocal: sharedPreferencesServices);
      // AuthRemoteDataSource authRemoteDataSourceImpl =
      //     AuthRemoteDataSourceImpl();
      // NetworkInfo networkInfo = NetworkInfoImpl();
      // AuthRepository authRepositoryImpl = AuthRepositoryImpl(
      //     localDataSource: authLocalDataSourceImpl,
      //     remoteDataSource: authRemoteDataSourceImpl,
      //     networkInfo: networkInfo);
     

      final params = SignUpParams(
          fullName: fullNameController.text,
          // userName: usernameController.text,
          email: emailController.text.toLowerCase().trim(),
          password: passwordController.text,
          imageUrl: selectedImage);
      BlocProvider.of<AuthBloc>(context).add(AuthSignUpEvent(params: params));
      // final result = await Signup(authRepositoryImpl).call(params);
      // result.fold((l) {
      //   print(l);
      // }, (r) {
      //   print(r);
      // });
    }
  }
}

mixin Icons {
  // IconData usernameIcon = Iconsax.user_search;
  IconData fullNameIcon = Iconsax.user;
  IconData lastNameIcon = Iconsax.user;
}
mixin Sizes {
  double get imageSize => 100.h;
}

mixin Strings {
  String signupString = "Signup";
  String fullNameString = "Enter your full name";
  // String usernameString = "Enter your username";
  // String usernameLabel = "username";
  String fullNameLabel = "Full name";
  String pickImageString = "Pick an image (Optional)";
}

mixin Validators {
  String? nameValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [
          RequiredValidator(),
          LognerThanChars(2),
        ],
        true,
      );

  // String? usernameValidator(String? value, BuildContext context) =>
  //     BaseValidator.validateValue(
  //       context,
  //       value ?? "",
  //       [RequiredValidator(), LognerThan2Chars(), NoSpaceValidator()],
  //       true,
  //     );
  String? confirmPasswordValidator(
          String? value, BuildContext context, String password) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [EqualToPasswordValidator(password)],
        true,
      );
}
