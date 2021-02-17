


import 'package:dio/dio.dart';
import 'package:new_test/models/category_model.dart';

class CategoryDatasource {
  final Dio dio;

  CategoryDatasource(this.dio);

  Future<List<Category>> getCategory() async {
    Response response = await dio.get('products/categories/');

    return (response.data as List).map((e) => Category.fromJson(e)).toList();
  }
}