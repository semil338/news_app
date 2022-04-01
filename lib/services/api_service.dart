import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/services/api.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService(this.api);
  final Api api;

  Future<News?> getNewsData(String text) async =>
      newsData(text, await http.get(api.getNewsData(text)));

  Future<News?> searchNewsData(String text) async =>
      newsData(text, await http.get(api.searchNews(text)));

  Future<News?> newsData(String text, Response resp) async {
    final response = resp;
    if (response.statusCode == 200) {
      final news = newsFromJson(response.body);
      return news;
    }
    debugPrint(response.reasonPhrase);
    throw response;
  }
}
