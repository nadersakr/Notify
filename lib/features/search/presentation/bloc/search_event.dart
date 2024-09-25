part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}
class SearchByTitleEvent extends SearchEvent {
 final SearchForChannelParams params;
 const SearchByTitleEvent(this.params);

  @override
  List<Object> get props => [];
}
class ClearSearchHistoryEvent extends SearchEvent {
 const ClearSearchHistoryEvent();

  @override
  List<Object> get props => [];
}
