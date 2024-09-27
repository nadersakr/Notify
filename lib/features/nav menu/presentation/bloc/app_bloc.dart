import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/utils/usecases/usecase.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_biggest_channel.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/domin/usecases/get_channel_data_using_id.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<GetStartUpAppDataEvent>((event, emit) async {
      try {
        emit(AppLoading());
        late final UserModel user;

        // Clear previous data
        LoadedUserData.biggestChannels.clear();
        LoadedUserData.joindChannels.clear();
        LoadedUserData.userownedChannels.clear();

        // Load user profile data
        GetUserInfo getUserInfo = sl<GetUserInfo>();
        final userDataResult = await getUserInfo.call(event.usereInfoParams);
        userDataResult.fold((l) {
          emit(AppFailed());
          return;
        }, (userData) {
          user = userData;
          LoadedUserData().loadedUser = user;
        });

        // Load biggest channels
        GetBiggestChannels getBiggestChannels = sl<GetBiggestChannels>();
        final biggestChannelsResult = await getBiggestChannels.call(NoParams());
        biggestChannelsResult.fold((l) {
          emit(AppFailed());
          return;
        }, (biggestChannels) {
          LoadedUserData.biggestChannels = biggestChannels;
        });
        GetChannelData getChannelData = sl<GetChannelData>();
        for (var channelId in user.joinedChannelsId) {
          final channelResult = await getChannelData
              .call(GetChannelInfoParams(channelId: channelId));
          channelResult.fold((l) {
            emit(AppFailed());
            return;
          }, (channelData) {
            LoadedUserData.joindChannels.add(channelData);
          });
        }

        // Load user's owned channels
        for (var channelId in user.ownedChannels) {
          final channelResult = await getChannelData
              .call(GetChannelInfoParams(channelId: channelId));
          channelResult.fold((l) {
            emit(AppFailed());
            return;
          }, (channelData) {
            LoadedUserData.userownedChannels.add(channelData);
          });
        }
        emit(AppSuccess());
      } catch (e) {
        emit(AppFailed());
      }
    });
  }
}
