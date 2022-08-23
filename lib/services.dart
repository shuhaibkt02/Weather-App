import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

class WeatherApiClient {
  Future<Weather>? getWeatherDetails(String? location) async {
    // request load

    final queryParameter = {
      'q': location,
      'appid': 'c5b3b5bedfc5c43ac2dd6825842229b4',
      'units': 'metric'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameter);

    // response load
    final response = await http.get(uri);
    // print(response.body);
    final body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}
