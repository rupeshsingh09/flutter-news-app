import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class ApiService {
  final String apiKey =
      '140bd7e412664f23ba491f49e0cba3f5'; // Use your NewsAPI key

  Future<List<NewsArticle>> fetchNews({
    String query = '',
    String category = '',
    int page = 1,
  }) async {
    final Map<String, String> params = {
      'apiKey': apiKey,
      'page': '$page',
      'pageSize': '20',
    };

    Uri uri;

    if (query.isNotEmpty) {
      params['q'] = query;
      uri = Uri.https('newsapi.org', '/v2/everything', params);
    } else {
      params['country'] =
          'us'; // CHANGED from 'in' to 'us' for more category data
      if (category.isNotEmpty) {
        params['category'] = category;
      }
      uri = Uri.https('newsapi.org', '/v2/top-headlines', params);
    }

    print("🟡 FETCHING FROM: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      print("❌ ERROR BODY: ${response.body}");
      throw Exception('Failed to load news');
    }
  }
}
