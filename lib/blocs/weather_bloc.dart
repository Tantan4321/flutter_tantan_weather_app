import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_tantan_weather_app/repositories/repositories.dart';
import 'package:flutter_tantan_weather_app/models/models.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  const FetchWeather();

  @override
  List<Object> get props => null;
}

class RefreshWeather extends WeatherEvent {
  final int location;

  const RefreshWeather({@required this.location}) : assert(location != null);

  @override
  List<Object> get props => [location];
}

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.initWeather();
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }

    if (event is RefreshWeather) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.location);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield state;
      }
    }
  }
}
