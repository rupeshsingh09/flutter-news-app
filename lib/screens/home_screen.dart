import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/api_service.dart';
import '../widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedCategory = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'business',
    'sports',
    'technology',
    'health',
    'science',
  ];

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    setState(() => _isLoading = true);
    try {
      final news = await _apiService.fetchNews(
        query: _searchQuery,
        category: _selectedCategory,
      );
      setState(() => _articles = news);
    } catch (e) {
      print('Error fetching news: $e');
      setState(() => _articles = []);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSearchSubmitted(String value) {
    setState(() => _searchQuery = value);
    _fetchArticles();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category == _selectedCategory ? '' : category;
    });
    _fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search news...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _onSearchSubmitted(_searchController.text),
            ),
          ),
          onSubmitted: _onSearchSubmitted,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children:
                  _categories.map((category) {
                    final isSelected = category == _selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) => _onCategorySelected(category),
                      ),
                    );
                  }).toList(),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child:
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _articles.isEmpty
                    ? Center(
                      child: Text(
                        _searchQuery.isEmpty && _selectedCategory.isNotEmpty
                            ? 'No articles found for "${_selectedCategory.toUpperCase()}" category'
                            : 'No articles found',
                      ),
                    )
                    : ListView.builder(
                      itemCount: _articles.length,
                      itemBuilder:
                          (context, index) =>
                              NewsCard(article: _articles[index]),
                    ),
          ),
        ],
      ),
    );
  }
}
