class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;
  final Map<String, dynamic>? source;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    this.source,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      content: json['content'] ?? '',
      source: json['source'],
    );
  }

  String get sourceName => source?['name'] ?? 'Unknown';
  String get imageUrl => urlToImage; // so your card uses this safely
}
