import 'dart:convert';
import 'dart:async';

import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_tantan_weather_app/models/models.dart';

class LocationApiClient {
  final loc = new Location();

  LocationApiClient();

  Future<List<String>> getLocationId() async {
    LocationData location;
      await loc.requestService();
      bool serviceStatus = await loc.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        bool permission = await loc.requestPermission();
        if(permission) {
          location = await loc.getLocation();
        }
      }

    final List<String> locationData = new List();
    locationData.add(location.latitude.toStringAsPrecision(10));
    locationData.add(location.longitude.toStringAsPrecision(10));
    return locationData;
  }



}
