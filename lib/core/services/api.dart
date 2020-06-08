import 'package:dio/dio.dart';

class Api {
  final _endpoint = "https://frutiland.herokuapp.com";
  Dio _dio;
  
  Api() {
    _dio = new Dio();
    _dio.options.baseUrl = _endpoint;
  }
}