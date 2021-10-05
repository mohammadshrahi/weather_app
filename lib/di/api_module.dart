import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/data/datasources/remote/weather_service.dart';

@module
abstract class ApiModule {
  Dio getDioClient() {
    return Dio();
  }
}
