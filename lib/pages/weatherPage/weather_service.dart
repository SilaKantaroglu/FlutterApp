import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_case/pages/weatherPage/weather_model.dart';

class WeatherService {
  static const String apiKey = 'apikey 0krWguQNkJzcfV41u58jE1:3FTBNJwgDolYigQ2MNoKxZ';
  static const String baseUrl = 'https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=ankara';

  static Future<WeatherModel> fetchWeather({String city = 'ankara'}) async {
    final apiUrl = 'https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city';
    final response = await http.get(Uri.parse(apiUrl), headers: {'Authorization': 'apikey $apiKey'});
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return WeatherModel.fromJson(jsonResponse);
    } else {
      throw Exception('Hava durumu bilgisi alınamadı: ${response.statusCode}');
    }
  }
}
