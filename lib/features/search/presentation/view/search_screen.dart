import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/core/app_injection.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/features/search/presentation/bloc/search_bloc.dart';
import 'package:notify/features/search/presentation/controller/search_controller.dart';
import 'package:notify/shared/presentaion/widget/channel_container.dart';
import 'package:notify/shared/presentaion/widget/custom_text_form_field.dart';
import 'package:notify/shared/presentation/controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final SearchChannelController _controller = SearchChannelController();

  @override
  void initState() {
    super.initState();
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
          if (state is SearchInitial) {
            _controller.isLoading = false;
            _controller.searchResults = [];
          }
          if (state is SearchFailure) {
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
                                return ChannelOverviewContainer(
                                  channel: _controller.searchResults[index],
                                );
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
                                BlocProvider.of<SearchBloc>(context)
                                    .add(const ClearSearchHistoryEvent()),
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
