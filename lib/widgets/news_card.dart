import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../screens/detail_screen.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({Key? key, required this.article})
    : super(key: key); // ✅ fixed key warning

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading:
            article.imageUrl.isNotEmpty
                ? Image.network(article.imageUrl, width: 100, fit: BoxFit.cover)
                : null,
        title: Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(article.sourceName ?? 'Unknown Source'), // ✅ safer
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailScreen(article: article)),
          );
        },
      ),
    );
  }
}
