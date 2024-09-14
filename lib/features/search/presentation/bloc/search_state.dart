part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<Channal> searchResults;

  const SearchLoaded(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}

final class SearchFailure extends SearchState {}
final class ClearSearchHistory extends SearchState {}
final class SearchHistoryLoaded extends SearchState {
  final List<String> searchHistory;

  const SearchHistoryLoaded(this.searchHistory);

  @override
  List<Object> get props => [searchHistory];
}
