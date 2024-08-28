import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/auth/domin/entities/user_model.dart';
import 'package:notify/features/auth/domin/usecases/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  AuthBloc({required this.login}) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(LoginLoading());
      Either<Failure, UserModel> response =
          await login.call(event.params);
      response.fold((l) {
        emit(LoginFailure(l.errorMessage));
      }, (r) {
        emit(LoginSuccess(user: r));
      });
    });
  }
}
