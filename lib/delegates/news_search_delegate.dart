import 'package:flutter/material.dart';

class NewsSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  NewsSearchDelegate({required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        query = '';
        showSuggestions(context);
      },
    ),
  ];

  @override
  Widget buildLeading(BuildContext context) => BackButton();

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    close(context, null);
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text("Type a keyword to search news..."),
    );
  }
}
