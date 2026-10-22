import 'package:dio/dio.dart';

import '../app/api_constants.dart';

class ApiClient {
  final Dio _dio = Dio();
  ApiClient() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.headers = {'Content-Type': 'application/json'};
  }

  Dio get dio => _dio;
}
