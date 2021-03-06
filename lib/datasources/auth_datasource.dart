import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AuthDatasource {
  final Dio dio;
  final Box tokens;

  AuthDatasource(this.dio, this.tokens);

  Future<Response> logIn({String email, String password}) async {
    Response response = await dio.post('token/', data: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == HttpStatus.ok) {
      tokens.put('access', response.data['access']);
      tokens.put('refresh', response.data['refresh']);
    }

    return response;
  }


  Future<Response> refreshToken()  {
    Future<Response> response = dio.post('token/refresh/', data: {
      'refresh': tokens.get('refresh'),
    });

    return response;
  }

  Future<Response> verifyAccessToken() => dio.post('token/verify/', data: {
        'token': tokens.get('access'),
      });


  Future<void> logOut() async {
    await tokens.delete('access');
    await tokens.delete('refresh');
  }
}
