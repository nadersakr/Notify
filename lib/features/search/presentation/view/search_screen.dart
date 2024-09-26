import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/search/presentation/bloc/search_bloc.dart';
import 'package:notify/features/search/presentation/controller/search_controller.dart';
import 'package:notify/shared/presentaion/widget/channel_container.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';
import 'package:notify/shared/presentaion/controller.dart';
import 'package:notify/shared/presentaion/widget/user_container.dart';

// This SearchScreen will dynamically handle both channel and user search
class SearchScreen extends StatefulWidget {
  final bool
      isChannelSearch; // Add a flag to differentiate between channel and user search
  final void Function(dynamic object)? onPressed;
  const SearchScreen({super.key, this.isChannelSearch = true, this.onPressed});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  late SearchBaseController _controller;

  @override
  void initState() {
    super.initState();
    // Depending on the flag, instantiate the appropriate controller
    _controller = widget.isChannelSearch
        ? SearchChannelController()
        : SearchUserController();
    _controller.loadSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>(),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            _controller.isLoading = true;
          }
          if (state is SearchLoaded) {
            _controller.isLoading = false;
            _controller.searchResults = state.searchResults;
          }
          if (state is SearchInitial || state is SearchFailure) {
            _controller.isLoading = false;
            _controller.searchResults = [];
          }
          if (state is ClearSearchHistory) {
            _controller.searchHistory = [];
          }

          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: AppUIController().widgetsWidth,
                child: Scaffold(
                  body: Form(
                    key: _controller.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: AppUIController().smallPaddingSpace),
                        CustomTextFormField(
                          validator: (String? value) =>
                              _controller.searchValidator(value, context),
                          textController: _controller.searchController,
                          labelText: _controller.searchLabel,
                          hintText: _controller.searchHint,
                          suffixWidget: IconButton(
                            icon: Icon(
                              _controller.searchIcon,
                              color: AppColors.gray,
                            ),
                            onPressed: () =>
                                _controller.onSearchSubmitted(context),
                          ),
                          onSubmitted: (text) =>
                              _controller.onSearchSubmitted(context),
                        ),
                        const SizedBox(height: 16),
                        if (_controller.isLoading)
                          const Expanded(
                              child: Center(child: CircularProgressIndicator()))
                        else
                          Expanded(
                            child: ListView.builder(
                              itemCount: _controller.searchResults.length,
                              itemBuilder: (context, index) {
                                // Dynamically handle result display
                                if (widget.isChannelSearch) {
                                  return GestureDetector(
                                    onTap: () {
                                      widget.onPressed!(_controller.searchResults[index]);
                                    },
                                    child: ChannelOverviewContainer(
                                      channel: _controller.searchResults[index],
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      widget.onPressed!(_controller.searchResults[index]);
                                    },
                                    child: UserOverviewContainer(
                                      user: _controller.searchResults[index],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        const SizedBox(height: 16),
                        if (_controller.searchHistory.isNotEmpty) ...[
                          Text(
                            _controller.searchHistoryLabel,
                            style: AppTextStyle.mediumBlack,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: _controller.searchHistory.map((query) {
                              return GestureDetector(
                                onTap: () {
                                  _controller.searchController.text = query;
                                  _controller.onSearchSubmitted(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(query),
                                ),
                              );
                            }).toList(),
                          ),
                          TextButton(
                            onPressed: () =>
                                _controller.clearSearchHistory(context),
                            child: Text(
                              _controller.clearHistoryLabel,
                              style: AppTextStyle.mediumOrangeBold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
