import 'package:dio/dio.dart';
import 'package:new_test/models/product_model.dart';

class ProductDatasource {
  final Dio dio;

  ProductDatasource(this.dio);

  Future<List<Product>> getProduct() async {
    Response response = await dio.get('products/');

    return (response.data as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> getFilteredProducts(String filter) async {
    Response response = await dio.get('products/?name=$filter');

    return (response.data as List).map((e) => Product.fromJson(e)).toList();
  }
}
