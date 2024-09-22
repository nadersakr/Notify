import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_biggest_channel.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  GetBiggestChannels getBiggestChannels;
  HomeBloc({required this.getBiggestChannels}) : super(HomeInitial()) {
    on<GetBiggestChannelsEvent>((event, emit) async {
      print("Get Biggest channels event");
      emit(HomeLoading());
      final result = await getBiggestChannels.call(NoParams());
      result.fold((l) {
        emit(HomeFailure(l.errorMessage));
      }, (r) {
        for (var element in r) {
          print(element.membersCount);
        }
        emit(GetBigetsChannelsLoaded(r));
      });
    });
  }
}
