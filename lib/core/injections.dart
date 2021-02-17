import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:new_test/bloc/auth/auth_bloc.dart';
import 'package:new_test/bloc/category/category_bloc.dart';
import 'package:new_test/core/auth_interceptors.dart';
import 'package:new_test/core/consts.dart';
import 'file:///C:/Users/natem/dev/new_test/lib/datasources/auth_datasource.dart';
import 'package:new_test/datasources/category_datasource.dart';
import 'package:new_test/datasources/product_datasource.dart';

final getIt = GetIt.instance;

void setupInjections() {
  getIt.registerFactory<Dio>(
    () => Dio(
      BaseOptions(baseUrl: API_URL),
    )..interceptors.add(AuthInterceptor()),
  );

  getIt.registerFactory<AuthDatasource>(() => AuthDatasource(getIt(), getIt()));

  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt(), getIt()));

  getIt.registerLazySingleton<Box>(() => Hive.box('tokens'));

  getIt.registerFactory<CategoryDatasource>(() => CategoryDatasource(getIt()));

  getIt.registerFactory<CategoryBloc>(() => CategoryBloc(getIt(), getIt(), getIt()));

  getIt.registerFactory<ProductDatasource>(() => ProductDatasource(getIt()));

}
