import 'package:cubit/config/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  late Dio _dio;

  Api() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    _dio = Dio(options);
  }

  Future<List> getCharacters(int pageNumber) async {
    try {
      Response response = await _dio.get('$charactersEndpoint?page=$pageNumber');
      return response.data['results'];
    } catch (e) {
      debugPrint('error: $e');
      return [];
    }
  }
}
