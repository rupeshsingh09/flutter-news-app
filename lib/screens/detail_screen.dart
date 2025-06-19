import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_article.dart';

class DetailScreen extends StatelessWidget {
  final NewsArticle article;

  const DetailScreen({Key? key, required this.article}) : super(key: key);

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(article.url ?? '');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${article.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Article Detail")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((article.urlToImage ?? '').isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.urlToImage!,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Image could not be loaded.');
                  },
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article.title ?? 'No Title',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              article.description ?? 'No description available.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                if ((article.url ?? '').isNotEmpty) {
                  _launchURL();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('URL not available')),
                  );
                }
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Read Full Article'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
