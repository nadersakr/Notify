part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

sealed class GetAllChannelsEvent extends Equatable {
  const GetAllChannelsEvent();

  @override
  List<Object> get props => [];
}

class GetBiggestChannelsEvent extends HomeEvent {
  const GetBiggestChannelsEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends HomeEvent {
  final GetUserInfoParams params;
  const GetUserDataEvent({required this.params});

  @override
  List<Object> get props => [];
}

