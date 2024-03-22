import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/models/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static Future<WeatherModel> fetchWeather(String lat, String long) async {
    final String apiKey = dotenv.env['API_KEY']!;
    final String url =
        'http://api.worldweatheronline.com/premium/v1/weather.ashx?key=$apiKey&q=$lat,$long&num_of_days=1&tp=3&format=json';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> weatherJson = json.decode(response.body);
      return WeatherModel.fromJson(weatherJson);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
