import 'package:bleach/common/constants.dart';
import 'package:bleach/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi{
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<WeatherModel> getCurrentWeatherLocation(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    //print("API URL: $apiUrl");

    try {
      final response = await http.get(Uri.parse(apiUrl));
      //print("status: ${response.statusCode}");
      //print("body: ${response.body}");

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        //print("Error: ${response.body}");
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      //print("Exception: $e");
      throw Exception("Failed to load weather");
    }
  }

}

