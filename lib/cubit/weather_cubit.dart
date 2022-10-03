import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_3/models/weather_data.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  refresh({
    double latitude = 52.52,
    double longitude = 13.41,
  }) async {
    emit(WeatherLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    var response = await Dio().get(
      "https://api.open-meteo.com/v1/forecast",
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'current_weather': true,
        'daily': [
          'weathercode',
          'temperature_2m_max',
          'temperature_2m_min',
          'apparent_temperature_max',
          'apparent_temperature_min',
          'sunrise',
          'sunset'
        ],
        'timezone': 'Europe/Paris',
      },
    );

    WeatherData weatherData = WeatherData.fromJson(response.data);
    emit(WeatherLoadedState(weatherData: weatherData));
  }

  @override
  void onChange(Change<WeatherState> change) {
    super.onChange(change);
    log(change.toString());
  }
}
