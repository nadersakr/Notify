part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final UserModel user;
  const LoginSuccess({required this.user});
}

final class LoginFailure extends AuthState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {
  final UserModel user;
  const SignUpSuccess({required this.user});
}


final class SignUpFailure extends AuthState {
  final String message;

  const SignUpFailure(this.message);

  @override
  List<Object> get props => [message];
}
