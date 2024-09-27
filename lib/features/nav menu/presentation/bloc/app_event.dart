part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class GetStartUpAppDataEvent extends AppEvent {
final  GetUserInfoParams usereInfoParams;
  
  const GetStartUpAppDataEvent({required this.usereInfoParams});
}