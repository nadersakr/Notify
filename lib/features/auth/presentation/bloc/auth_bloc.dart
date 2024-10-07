import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/auth/domin/usecases/log_out.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';
import 'package:notify/shared/domin/models/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signin_with_google.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
import 'package:notify/shared/domin/usecases/compress_image_usecase.dart';
import 'package:notify/shared/domin/usecases/upload_image_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Signup signup;
  final SigninWithGoogle signinWithGooogle;
  final LogOut logOut;
  final CompressImage compressImage;
  final UploadImage uploadImage;
  AuthBloc(
      {required this.uploadImage,
      required this.compressImage,
      required this.login,
      required this.logOut,
      required this.signup,
      required this.signinWithGooogle})
      : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      Either<Failure, UserModel> response = await login.call(event.params);
      response.fold((l) {
        emit(AuthFailure(l.errorMessage));
      }, (r) {
        LoadedUserData().loadedUser = r;
        emit(AuthSuccess(user: r));
      });
    });
    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());
      if (event.params.imageUrl != null) {
        compressImage
            .call(CompressImageParams(image: File(event.params.imageUrl!)))
            .then((value) {
          value.fold((l) {
            emit(AuthFailure(l.errorMessage));
          }, (r) {
            uploadImage.call(UploadImageParams(image: r)).then((value) {
              value.fold((l) {
                emit(AuthFailure(l.errorMessage));
              }, (r) {
                event.params.imageUrl = r;
                print(r);
                print("==============================");
              });
            });
          });
        });
      }
      Either<Failure, UserModel> response = await signup.call(event.params);
      response.fold((l) {
        emit(AuthFailure(l.errorMessage));
      }, (r) {
        LoadedUserData().loadedUser = r;
        emit(AuthSuccess(user: r));
      });
    });
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      Either<Failure, UserModel> response =
          await signinWithGooogle.call(NoParams());
      response.fold((l) {
        emit(AuthFailure(l.errorMessage));
      }, (r) {
        LoadedUserData().loadedUser = r;
        emit(AuthSuccess(user: r));
      });
    });
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      Either<Failure, void> response = await logOut.call(NoParams());
      response.fold((l) {
        emit(AuthFailure(l.errorMessage));
      }, (r) {
        LoadedUserData().loadedUser = null;
        emit(AuthInitial());
      });
    });
  }
}
