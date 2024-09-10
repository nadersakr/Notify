import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';
import 'package:notify/features/auth/domin/usecases/signin_with_google.dart';
import 'package:notify/features/auth/domin/usecases/signup.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Signup signup;
  final SigninWithGoogle signinWithGooogle;
  AuthBloc(
      {required this.login,
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
  }
}
