import 'package:http/http.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/services/api_service.dart';

class DataRepository {
  DataRepository({required this.apiService});
  final ApiService apiService;

  Future<News?> getNewsData(String text) async {
    try {
      return await apiService.getNewsData(text);
    } on Response catch (_) {
      rethrow;
    }
  }

  Future<News?> searchNewsData(String text) async {
    try {
      return await apiService.searchNewsData(text);
    } on Response catch (_) {
      rethrow;
    }
  }
}
