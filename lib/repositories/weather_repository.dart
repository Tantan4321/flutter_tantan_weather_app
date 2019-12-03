import 'dart:async';

import 'package:flutter_tantan_weather_app/repositories/location_api_client.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

import 'package:flutter_tantan_weather_app/repositories/weather_api_client.dart';
import 'package:flutter_tantan_weather_app/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;
  final LocationApiClient locationApiClient;

  WeatherRepository({@required this.locationApiClient, @required this.weatherApiClient})
      : assert(weatherApiClient != null);


  Future<Weather> getWeather(int locationId) async {
    return await weatherApiClient.fetchWeather(locationId);
  }

  Future<Weather> initWeather() async {
    final List<String> location = await locationApiClient.getLocationId();
    final int locationID = await weatherApiClient.getLocationId(location);
    return await weatherApiClient.fetchWeather(locationID);

  }

}
