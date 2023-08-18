import 'package:weather_service/data/models/clouds.dart';
import 'package:weather_service/data/models/main_data.dart';
import 'package:weather_service/data/models/sys.dart';
import 'package:weather_service/data/models/weather_description.dart';
import 'package:weather_service/data/models/wind.dart';

class WeatherData {
  final int dt;
  final MainData main;
  final List<WeatherDescription> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Sys sys;
  final String dtTxt;

  WeatherData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      dt: json['dt'],
      main: MainData.fromJson(json['main']),
      weather: List<WeatherDescription>.from(
        json['weather'].map((data) => WeatherDescription.fromJson(data)),
      ),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': weather.map((data) => data.toJson()).toList(),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'visibility': visibility,
      'pop': pop,
      'sys': sys.toJson(),
      'dt_txt': dtTxt,
    };
  }
}
