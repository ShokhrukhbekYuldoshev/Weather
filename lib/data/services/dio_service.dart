import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// https://api.openweathermap.org/data/2.5/forecast?units=metric&lang=ru&lat=59.9096324&lon=30.522676&appid={openWeatherMapApiKey}
class DioService {
  Dio dio = Dio();

  DioService() {
    dio.options.baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
  }

  Future<Response> get(String path) async {
    try {
      return await dio.get(dio.options.baseUrl + path);
    } on DioException catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      throw Exception(e.message);
    }
  }
}
