part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeFailure extends HomeState {}
final class GetAllChannelsLoaded extends HomeState {}
final class GetMyChannelsLoaded extends HomeState {}
