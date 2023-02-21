import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:users_db/constants/constants.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';

class ApiService {
  ApiService() {
    init();
  }

  final dio = Dio(BaseOptions(
    baseUrl: Constants.BASE_URL,
  ));

  init() {
    dio.interceptors.add(LoggyDioInterceptor());
  }

  Future<Response> getRequest(
      String endpoint, Map<String, dynamic> queryParams) async {
    try {
      final res = await dio.get(endpoint, queryParameters: queryParams);
      return res;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> queryParams) async {
    try {
      final res = await dio.post(endpoint, data: jsonEncode(queryParams));
      return res;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
