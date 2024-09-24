part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class GetUserDataLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String errorMessage;
  const HomeFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

final class GetBigetsChannelsLoaded extends HomeState {
  final List<Channel> channels;
  const GetBigetsChannelsLoaded(this.channels);
}

final class GetUserDataSuccess extends HomeState {
  final UserModel user;
  const GetUserDataSuccess(this.user);
}
