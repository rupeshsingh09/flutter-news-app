import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String content;
  final String sourceUrl;

  const ArticleDetailScreen({
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.sourceUrl,
  });

  void _launchURL() async {
    if (await canLaunchUrl(Uri.parse(sourceUrl))) {
      await launchUrl(Uri.parse(sourceUrl));
    } else {
      throw 'Could not launch $sourceUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Article Detail")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(imageUrl),
                ),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(content, style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _launchURL,
                child: Text("Read Full Article"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
