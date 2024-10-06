import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/less_than.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:notify/features/search/domin/usecases/search_for_channel.dart';
import 'package:notify/features/search/domin/usecases/search_for_user.dart';
import 'package:notify/features/search/presentation/bloc/search_bloc.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class SearchBaseController with SearchStrings, SearchIcons {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<dynamic> searchResults = [];  // Make this dynamic to support both users and channels
  List<String> searchHistory = [];
  bool isLoading = false;

  void loadSearchHistory() {
    searchHistory = sl<SharedPreferences>().getStringList(LoadedUserData().loadedUser == null
            ? "userId"
            : LoadedUserData().loadedUser!.id) ??
        [];
  }

  Future<void> saveSearchHistory(String searchTerm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!searchHistory.contains(searchTerm)) {
      searchHistory.insert(0, searchTerm);
      if (searchHistory.length > 4) {
        searchHistory.removeAt(searchHistory.length - 1);
      }
      await prefs.setStringList(LoadedUserData().loadedUser!.id, searchHistory);
    }
  }

  void onSearchSubmitted(BuildContext context) {
    if (formKey.currentState!.validate()) {
      saveSearchHistory(searchController.text);
      executeSearch(context);
    }
  }

  clearSearchHistory(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(const ClearSearchHistoryEvent());
    searchHistory = [];
  }

  String? searchValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LessThanChars(15)],
        true,
      );

  // Override this method in child classes to perform specific searches (channels or users)
  void executeSearch(BuildContext context);
}

mixin SearchStrings {
  String get searchLabel;
  String get searchHint;
  String get searchHistoryLabel => 'Search History';
  String get clearHistoryLabel => 'Clear Search History';
}

mixin SearchIcons {
  IconData get searchIcon;
}

class SearchChannelController extends SearchBaseController {
  @override
  String get searchLabel => "Search Channels";
  @override
  String get searchHint => "Search for Channels";
  @override
  IconData get searchIcon => Iconsax.search_normal_1;

  @override
  void executeSearch(BuildContext context) {
    SearchForChannelParams params = SearchForChannelParams(query: searchController.text);
    BlocProvider.of<SearchBloc>(context).add(SearchByTitleEvent(params));
  }
}


class SearchUserController extends SearchBaseController {
  @override
  String get searchLabel => "Search Users";
  @override
  String get searchHint => "Search for Users";
  @override
  IconData get searchIcon => Iconsax.user_search;

  @override
  void executeSearch(BuildContext context) {
    SearchForUserParams params = SearchForUserParams(query: searchController.text);
    BlocProvider.of<SearchBloc>(context).add(SearchByUserEvent(params));  // Add user-specific event
  }
}
