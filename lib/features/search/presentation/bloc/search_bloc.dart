import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/shared/domin/entities/fake_channals_for_test.dart';
import 'package:notify/shared/domin/entities/group_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchByTitleEvent>((event, emit) {
      emit(SearchLoading());
      final searchResults = channalList
          .where((item) =>
              item.title.toLowerCase().contains(event.title.toLowerCase()))
          .toList();
      emit(SearchLoaded(searchResults));
    });
    on<ClearSearchHistoryEvent>((event, emit) {
      sl<SharedPreferences>().remove('searchHistory');
      print("cleaaaaaaaaaaaaaaaaaaar");
      emit(ClearSearchHistory());
    });
  }
}
