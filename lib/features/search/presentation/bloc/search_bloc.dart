import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/features/search/domin/usecases/search.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchForChannel searchForChannel;
  SearchBloc({required this.searchForChannel}) : super(SearchInitial()) {
    on<SearchByTitleEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await searchForChannel(event.params);
      result.fold((failure) {
      emit(SearchFailure());
      }, (channelList) {
      emit(SearchLoaded(channelList));
      });
      // final searchResults = channelList
      //     .where((item) => item.title
      //         .toLowerCase()
      //         .contains(event.params.query.toLowerCase()))
      //     .toList();
    });
    on<ClearSearchHistoryEvent>((event, emit) {
      sl<SharedPreferences>().remove('searchHistory');
      emit(ClearSearchHistory());
    });
  }
}
