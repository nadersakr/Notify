import 'package:flutter/material.dart';

class ViewAllScreen<T> extends StatefulWidget {
  final List<T> initialItems;
  final Future<List<T>> Function() loadMoreItems;
  final Widget Function(T item) itemBuilder;

  const ViewAllScreen({
    super.key,
    required this.initialItems,
    required this.loadMoreItems,
    required this.itemBuilder,
  });

  @override
  ViewAllScreenState<T> createState() => ViewAllScreenState<T>();
}

class ViewAllScreenState<T> extends State<ViewAllScreen<T>> {
  late List<T> items;
  late ScrollController _scrollController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    items = widget.initialItems;
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            !isLoading) {
          _loadMore();
        }
      });
  }

  Future<void> _loadMore() async {
    setState(() {
      isLoading = true;
    });
    List<T> newItems = await widget.loadMoreItems();
    setState(() {
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount:
            items.length + (isLoading ? 1 : 0), // +1 for loading indicator
        itemBuilder: (context, index) {
          if (index == items.length) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          }
          return widget.itemBuilder(items[index]);
        },
      ),
    );
  }
}

