import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {

  Dio dio = Dio();

  DioClient() {
    dio
      ..options.connectTimeout = Duration(milliseconds: 30000)
      ..options.receiveTimeout = Duration(milliseconds: 30000)
      ..httpClientAdapter;
  }

  Future<Response> getApiResponse(String url) async {

    dio..options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      if(kDebugMode) print('url> $url');

      var response = await dio.get(url);
      if(kDebugMode) print('res> $response');
      return response;

    } on DioException catch(e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postApiResponse(String url, var param) async {

    dio..options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      if(kDebugMode) print('url> $url');
      if(kDebugMode) print('body> $param');

      var response = await dio.get(url, data: param);
      if(kDebugMode) print('res> $response');
      return response;

    } on DioException catch(e)  {
      throw Exception(e.message);
    }
  }

}