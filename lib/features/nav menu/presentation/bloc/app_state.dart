part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();
  
  @override
  List<Object> get props => [];
}

final class AppInitial extends AppState {}
final class AppLoading extends AppState {}
final class AppFailed extends AppState {
  final String errorMessage;
  
  const AppFailed({required this.errorMessage});
  
  @override
  List<Object> get props => [errorMessage];
}
final class AppSuccess extends AppState {}
