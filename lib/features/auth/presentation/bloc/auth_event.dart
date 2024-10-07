part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final LoginParams params;

  const AuthLoginEvent({
    required this.params,
  });

  @override
  List<Object> get props => [params.email, params.password];
}

class AuthSignUpEvent extends AuthEvent {
  SignUpParams params;

  AuthSignUpEvent({
    required this.params,
  });

  @override
  List<Object> get props => [params.email, params.password];
}

class SignInWithGoogleEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
