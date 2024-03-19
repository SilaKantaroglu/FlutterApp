import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_case/pages/newsPage/news_model.dart';

class NewsService {
  static const String apiKey = 'apikey 0krWguQNkJzcfV41u58jE1:3FTBNJwgDolYigQ2MNoKxZ';
  static const String baseUrl = 'https://api.collectapi.com/news/getNews?country=tr&tag=general';

  static Future<NewsModel?> fetchNews({String tag = 'general'}) async {
    final String apiUrl = 'https://api.collectapi.com/news/getNews?country=tr&tag=$tag';
    final response = await http.get(Uri.parse(apiUrl), headers: {'Authorization': 'apikey $apiKey'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      return NewsModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
