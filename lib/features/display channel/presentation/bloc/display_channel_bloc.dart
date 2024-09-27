import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/display%20channel/domin/usecases/load_channel_data.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';

part 'display_channel_event.dart';
part 'display_channel_state.dart';

class DisplayChannelBloc extends Bloc<DisplayChannelEvent, DisplayChannelState> {
  final LoadChannelData loadChannelData;

  DisplayChannelBloc({required this.loadChannelData}) : super(DisplayChannelInitial()) {
    on<GetChannelDataEvent>((event, emit) async { // async is correct here
      List<UserModel> members = [];
      List<UserModel> supervisors = [];
      GetUserInfo getUserInfo = sl<GetUserInfo>();

      emit(DisplayChannelLoading());

      Either<Failure, Channel> response = await loadChannelData.call(event.params);

      await response.fold((failure) async {
        emit(DisplayChannelFailed(failure.errorMessage));
      }, (channel) async {
        // Load members asynchronously
        for (var element in channel.membersId) {
          final result = await getUserInfo.call(GetUserInfoParams(userId: element));
          await result.fold<Future<void>>((failure) async {
            emit(DisplayChannelFailed(failure.errorMessage));
          }, (user) async {
            members.add(user);
          });
          if (emit.isDone) return; // Check if emit is done before continuing
        }

        // Load supervisors asynchronously
        for (var element in channel.supervisorsId) {
          final result = await getUserInfo.call(GetUserInfoParams(userId: element));
           await result.fold<Future<void>>((failure) async {
            emit(DisplayChannelFailed(failure.errorMessage));
          }, (user) async {
            supervisors.add(user);
          });
          if (emit.isDone) return; // Check if emit is done before continuing
        }

        // Emit the final state after all operations are complete
        if (!emit.isDone) {
          emit(DisplayChannelLoaded(
            channel: channel,
            members: members,
            supervisors: supervisors,
          ));
        }
      });
    });
  }
}

