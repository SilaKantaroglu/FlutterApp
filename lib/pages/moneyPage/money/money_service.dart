import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_case/pages/moneyPage/money/money_model.dart';

class MoneyService {
  static const String apiKey = 'apikey 7xV5bD188kmzHvRhY71nye:3ynkGHg3QAdivBGYHttjc0';
  static const String baseUrl = 'https://api.collectapi.com/economy/allCurrency';

  static Future<MoneyModel?> fetchMoney() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {'Authorization': 'apikey $apiKey'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return MoneyModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
