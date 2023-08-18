// {
//   "cod": "200",
//   "message": 0,
//   "cnt": 40,
//   "list": [
//     {
//       "dt": 1692306000,
//       "main": {
//         "temp": 290.07,
//         "feels_like": 290.12,
//         "temp_min": 288.23,
//         "temp_max": 290.07,
//         "pressure": 1024,
//         "sea_level": 1024,
//         "grnd_level": 1023,
//         "humidity": 88,
//         "temp_kf": 1.84
//       },
//       "weather": [
//         {
//           "id": 800,
//           "main": "Clear",
//           "description": "clear sky",
//           "icon": "01n"
//         }
//       ],
//       "clouds": {
//         "all": 0
//       },
//       "wind": {
//         "speed": 1.99,
//         "deg": 311,
//         "gust": 3.57
//       },
//       "visibility": 10000,
//       "pop": 0,
//       "sys": {
//         "pod": "n"
//       },
//       "dt_txt": "2023-08-17 21:00:00"
//     },
//   ],
//   "city": {
//     "id": 498817,
//     "name": "Saint Petersburg",
//     "coord": {
//       "lat": 59.9096,
//       "lon": 30.5227
//     },
//     "country": "RU",
//     "population": 0,
//     "timezone": 10800,
//     "sunrise": 1631799600,
//     "sunset": 1631844240
//   }
// }

import 'package:weather_service/data/models/city.dart';
import 'package:weather_service/data/models/weather_data.dart';

class Weather {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherData> list;
  final City city;

  Weather({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  // empty weather
  factory Weather.empty() {
    return Weather(
      cod: '',
      message: 0,
      cnt: 0,
      list: [],
      city: City.empty(),
    );
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: List<WeatherData>.from(
        json['list'].map((data) => WeatherData.fromJson(data)),
      ),
      city: City.fromJson(json['city']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((data) => data.toJson()).toList(),
      'city': city.toJson(),
    };
  }
}
