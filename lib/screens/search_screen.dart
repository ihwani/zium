import 'package:flutter/material.dart';
import 'package:zium/source/search_input_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const SearchInputData();
  }
}
