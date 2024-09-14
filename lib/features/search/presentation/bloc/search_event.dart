part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}
class SearchByTitleEvent extends SearchEvent {
 final String title;
 const SearchByTitleEvent(this.title);

  @override
  List<Object> get props => [];
}
class ClearSearchHistoryEvent extends SearchEvent {
 const ClearSearchHistoryEvent();

  @override
  List<Object> get props => [];
}
