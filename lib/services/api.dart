import 'package:news_app/services/api_key.dart';

class Api {
  Api({required this.apiKey});

  final String apiKey;
  factory Api.key() => Api(apiKey: ApiKey.apiKey);

  static const String host = "newsapi.org";
  static const String path = "/v2/top-headlines";

  Uri getNewsData(String text) => news(text, "category");
  Uri searchNews(String text) => news(text, "q");

  Uri news(String text, String q) => Uri(
        scheme: "https",
        host: host,
        path: path,
        queryParameters: {
          "apiKey": apiKey,
          q: text,
          "country": "in",
          // "pageSize": 100,
        },
      );
}
