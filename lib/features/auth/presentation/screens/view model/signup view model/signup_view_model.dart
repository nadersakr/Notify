import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/network/network_info.dart';
import 'package:notify/core/routers/app_routers_enum.dart';
import 'package:notify/core/utils/shared%20preferances/shared_preferences.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/equal_to_validator.dart';
import 'package:notify/core/utils/validators/longer_than_2_chars.dart';
import 'package:notify/core/utils/validators/no_space_validator.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:notify/features/auth/data/data_source/local/local_data_source_impl.dart';
import 'package:notify/features/auth/data/data_source/local/local_data_sourece.dart';
import 'package:notify/features/auth/data/data_source/remote_data_source.dart';
import 'package:notify/features/auth/data/data_source/remote_data_source_impl.dart';
import 'package:notify/features/auth/data/repository/auth_repo_impl.dart';
import 'package:notify/features/auth/domin/repository/auth_repository.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
import 'package:notify/features/auth/presentation/screens/view model/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupViewModle extends AuthViewModel
    with Icons, Strings, Sizes, Validators {
  @override
  String get stringGoTo => "Login";

  @override
  Function(BuildContext context) get navigatotGoTO => (BuildContext context) {
        Navigator.pushReplacementNamed(
          context,
          AppRouteEnum.loginPage.name,
        );
      };

  @override
  String get donothaveAccountString => "Already have an account?";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  Future<void> signUpWithEmail() async {
    if (formKey.currentState!.validate()) {
      print("email : ${emailController.text.toLowerCase().trim()}");
      print("password : ${passwordController.text}");
      print("first name : ${firstNameController.text}");
      print("last name : ${lastNameController.text}");
      print("username : ${usernameController.text}");
      print("confirm password : ${confirmPasswordController.text}");
      SharedPreferences sharedPreferncesServices =
          await SharedPreferences.getInstance();

      SharedPreferencesServices sharedPreferencesServices =
          SharedPreferencesServices(
              sharedPreferences: sharedPreferncesServices);
      AuthLocalDataSource authLocalDataSourceImpl = AuthLocalDataSourceImp(
          saveDataLocal: sharedPreferencesServices);
      AuthRemoteDataSource authRemoteDataSourceImpl =
          AuthRemoteDataSourceImpl();
      NetworkInfo networkInfo = NetworkInfoImpl();
      AuthRepository authRepositoryImpl = AuthRepositoryImpl(
          localDataSource: authLocalDataSourceImpl,
          remoteDataSource: authRemoteDataSourceImpl,
          networkInfo: networkInfo);

      final params = SignUpParams(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: usernameController.text,
        email: emailController.text.toLowerCase().trim(),
        password: passwordController.text,
      );
      final result = await Signup(authRepositoryImpl).call(params);
      result.fold((l) {
        print(l);
      }, (r) {
        print(r);
      });
    }
  }
}

mixin Icons {
  IconData usernameIcon = Iconsax.user_search;
  IconData firstNameIcon = Iconsax.user;
  IconData lastNameIcon = Iconsax.user;
}

mixin Strings {
  String signupString = "Signup";
  String firstNameLabel = "First Name";

  String lastNameLabel = "Last Name";
  String usernameString = "Enter your username";
  String usernameLabel = "username";
}

mixin Validators {
  String? nameValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LognerThan2Chars(), NoSpaceValidator()],
        true,
      );

  String? usernameValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LognerThan2Chars(), NoSpaceValidator()],
        true,
      );
  String? confirmPasswordValidator(
          String? value, BuildContext context, String password) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [EqualToPasswordValidator(password)],
        true,
      );
}
