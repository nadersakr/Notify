import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/features/search/domin/usecases/search_for_channel.dart';
import 'package:notify/features/search/domin/usecases/search_for_user.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchForChannel searchForChannel;
  SearchForUser searchForUser;
  SearchBloc({required this.searchForChannel, required this.searchForUser})
      : super(SearchInitial()) {
    on<SearchByTitleEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await searchForChannel(event.params);
      result.fold((failure) {
        emit(const SearchFailure());
      }, (channelList) {
        emit(SearchLoaded(channelList));
      });
    });
    on<SearchByUserEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await searchForUser(event.params);
      result.fold((failure) {
        emit(SearchFailure(errorMessage: failure.toString()));
      }, (usersList) {
        emit(SearchLoaded(usersList));
      });
    });
    on<ClearSearchHistoryEvent>((event, emit) {
      sl<SharedPreferences>().remove(LoadedUserData().loadedUser == null
            ? "userId"
            : LoadedUserData().loadedUser!.id);
      print("removed");
      emit(ClearSearchHistory());
    });
  }
}
