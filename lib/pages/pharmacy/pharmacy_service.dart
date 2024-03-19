import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:staj_case/pages/pharmacy/pharmacy_model.dart';

class PharmacyService {
  static const String apikey = 'apikey 0krWguQNkJzcfV41u58jE1:3FTBNJwgDolYigQ2MNoKxZ';
  static const String baseUrl = 'https://api.collectapi.com/health/dutyPharmacy?&il=Ankara';

  static Future<PharmacyModel?> fetchPharmacy({String il = 'ankara'}) async {
    final String apiUrl = 'https://api.collectapi.com/health/dutyPharmacy?&il=$il';
    final response = await http.get(Uri.parse(apiUrl), headers: {'Authorization': 'apikey $apikey'});
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return PharmacyModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }
}
