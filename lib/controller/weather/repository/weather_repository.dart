import 'dart:convert';

import 'package:weather_app/controller/weather/data_provider/weather_data_provider.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherRepository {
  WeatherRepository(this.weatherDataProvider);

  final WeatherDataProvider weatherDataProvider;
  Future<List<WeatherModel>> getCurrentWeather(String cityName) async {
    try {
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        if (data['message'] == 'city not found') {
          throw 'Nem jó város nevet írtál be!';
        }
        throw 'An unexpected error occurred!';
      }
      final List<WeatherModel> weatherDataList = [];
      for (var i = 0; i < 40; i += 8) {
        weatherDataList.add(WeatherModel.fromMap(data, i));
      }

      return weatherDataList;
    } catch (e) {
      throw e.toString();
    }
  }
}
