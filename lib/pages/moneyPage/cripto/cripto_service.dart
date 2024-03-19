import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_case/pages/moneyPage/cripto/cripto_model.dart';

class CriptoService {
  static const String apiKey = 'apikey 6auUY38CImmcH4nmMVjLni:6TtR9FRoeGh3sBVjIjrJJs';
  static const String baseUrl = 'https://api.collectapi.com/economy/cripto';

  static Future<CriptoModel?> fetchCripto() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {'Authorization': 'apikey $apiKey'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return CriptoModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
