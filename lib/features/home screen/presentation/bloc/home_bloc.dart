import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_biggest_channel.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_user_data.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/domin/usecases/get_channel_data_using_id.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBiggestChannels getBiggestChannels;
  final GetUserData getUserData;
  HomeBloc({required this.getBiggestChannels, required this.getUserData})
      : super(HomeInitial()) {
    on<GetBiggestChannelsEvent>((event, emit) async {
      // emit(HomeLoading());
      // final result = await getBiggestChannels.call(NoParams());
      // result.fold((l) {
      //   emit(HomeFailure(l.errorMessage));
      // }, (r) {
      //   emit(GetBigetsChannelsLoaded(r));
      // });
    });
    on<GetUserDataEvent>((event, emit) async {
      // emit(GetUserDataLoading());
      // final result = await getUserData.call(event.params);

      // await result.fold((l) async {
      //   emit(HomeFailure(l.errorMessage));
      // }, (user) async {
      //   LoadedUserData.userownedChannels.clear();
      //   GetChannelData getChannelData = sl<GetChannelData>();

      //   // Await the result of each call
      //   for (var element in user.ownedChannels) {
      //     final channelResult = await getChannelData
      //         .call(GetChannelInfoParams(channelId: element));

      //     await channelResult.fold((l) async {
      //       emit(HomeFailure(l.errorMessage));
      //     }, (channel) async {
      //       LoadedUserData.userownedChannels.add(channel);
      //     });
      //   }

      //   emit(GetUserDataSuccess(user));
      // });
    });
  }
}
