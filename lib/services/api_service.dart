import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/services/api.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService(this.api);
  final Api api;

  Future<News?> getNewsData(String text) async {
    final response = await http.get(api.getNewsData(text));
    if (response.statusCode != 200) {
      final news = newsFromJson(response.body);
      // final articles = news.articles;
      // for (var article in articles!) {
      //   // debugPrint(article.author);
      //   // debugPrint(article.content);
      //   // debugPrint(article.description);
      //   // debugPrint(article.publishedAt);
      //   debugPrint(article.urlToImage);
      // }
      return news;
    }
    throw response;
  }
}
