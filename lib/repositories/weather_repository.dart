import 'dart:async';

import 'package:meta/meta.dart';

import 'package:flutter_tantan_weather_app/repositories/weather_api_client.dart';
import 'package:flutter_tantan_weather_app/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(int locationId) async {
    return await weatherApiClient.fetchWeather(locationId);
  }

  Future<Weather> initWeather() async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}
