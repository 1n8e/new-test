import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'file:///C:/Users/natem/dev/new_test/lib/datasources/auth_datasource.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Box tokens;
  final AuthDatasource authDatasource;

  AuthBloc(this.tokens, this.authDatasource) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckAuthEvent) {
      yield LoadingAuthState();
      try {
        String accessToken = tokens.get('access');
        if (accessToken != null) {
          await authDatasource.verifyAccessToken();

          yield AuthenticatedState();
        } else {
          yield NotAuthState();
        }
      } on DioError catch (e) {
        this.add(CheckAuthEvent());
      }
    } else if (event is LoginEvent) {
      yield LoadingAuthState();
      try {
        await authDatasource.logIn(email: event.email, password: event.password);
        yield AuthenticatedState();
      } catch (e) {
        yield AuthFailureState();
        throw e;
      }
    } else if (event is LogOutEvent) {
      await authDatasource.logOut();
     yield NotAuthState();

      print(state);
    }
  }
}
