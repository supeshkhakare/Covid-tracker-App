import 'dart:convert';

import 'package:covid_tracker_app/Models/Utilities/base_url.dart';
import 'package:covid_tracker_app/Models/WorldData.dart';
import 'package:http/http.dart' as http;

class Api_fetch_func {
  static Future<WorldData> getWorldData() async {
    final response = await http.get(Uri.parse(BaseUrl.world));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return WorldData.fromJson(data);
    } else {
      throw Exception("Failed to fetch WorldData.");
    }
  }

  // api se data Lenge and List mein add karenge aur fir uss list ka use
  // karke app mein data dikhayenge using futureBuilder
  static Future<List<dynamic>> getCountriesdata() async {
    final response = await http.get(Uri.parse(BaseUrl.countries));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // abb yea sara data list mein add hoga.
      return data;
    } else {
      throw Exception("Failed to fetch WorldData.");
    }
  }
}
