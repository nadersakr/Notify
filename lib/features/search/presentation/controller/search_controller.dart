import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/utils/validators/base_validator.dart';
import 'package:notify/core/utils/validators/less_than.dart';
import 'package:notify/core/utils/validators/required_validator.dart';
import 'package:notify/features/search/presentation/bloc/search_bloc.dart';
import 'package:notify/shared/domin/entities/group_model.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchChannalController with SearchStrings, SearchIcons {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Channal> searchResults = [];
  List<String> searchHistory = [];
  bool isLoading = false;

  void loadSearchHistory() {
    searchHistory = sl<SharedPreferences>()
            .getStringList(LoadedUserData().loadedUser!.id) ??
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

  // Future<void> onSearchChanged(String query) async {
  //   isLoading = true;
  //   await Future.delayed(const Duration(seconds: 2));
  //   isLoading = false;
  //   searchResults = fakeData
  //       .where((item) => item.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  // }

  void onSearchSubmitted(BuildContext context) {
    BlocProvider.of<SearchBloc>(context)
        .add(SearchByTitleEvent(searchController.text));
    if (formKey.currentState!.validate()) {
      saveSearchHistory(searchController.text);
      // onSearchChanged(searchController.text);
    }
  }

  clearSearchHistory(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(const ClearSearchHistoryEvent());
    print("cleaaaaaaaaaaaaaaaaaaaaaaaaaar history");
    searchHistory = [];
  }

  String? searchValidator(String? value, BuildContext context) =>
      BaseValidator.validateValue(
        context,
        value ?? "",
        [RequiredValidator(), LessThanChars(15)],
        true,
      );
}

mixin SearchStrings {
  String get searchLabel => "Search";
  String get searchHint => 'Search for Channels';
  String get searchHistoryLabel => 'Search History';
  String get clearHistoryLabel => 'Clear Search History';
}

mixin SearchIcons {
  IconData get searchIcon => Iconsax.search_normal_1;
}
