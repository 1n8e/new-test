import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final Box tokens = Hive.box('tokens');
  final Dio dio = Dio();

  @override
  Future onRequest(RequestOptions options) async {
    String accessToken = tokens.get('access');

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) async {
    String refreshToken = tokens.get('refresh');
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      if (refreshToken != null) {
        final Response response =
            await dio.post('token/', data: {'refresh': refreshToken});
        if (response.statusCode == HttpStatus.unauthorized) {
          tokens.delete('refresh');
          tokens.delete('access');
        } else if (response.statusCode == HttpStatus.ok) {
          tokens.put('access', response.data['access']);
          tokens.put('refresh', response.data['refresh']);
        }
      }
    }

    return super.onError(err);
  }
}
