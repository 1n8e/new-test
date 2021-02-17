part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class AuthenticatedState extends AuthState {}

class NotAuthState extends AuthState {}

class AuthFailureState extends AuthState {}
