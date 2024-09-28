import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_biggest_channel.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_user_data.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBiggestChannels getBiggestChannels;
  final GetUserData getUserData;
  HomeBloc({required this.getBiggestChannels, required this.getUserData})
      : super(HomeInitial()) {
    ;
  }
}
