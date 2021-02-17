part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<Category> categories;

  CategorySuccess(this.categories);
}

class CategoryFailure extends CategoryState {
  final String error;

  CategoryFailure(this.error);
}

class ProductSuccess extends CategoryState {
  final List<Product> products;

  ProductSuccess(this.products);
}

class FilteredProductState extends CategoryState {
  final List<Product> products;

  FilteredProductState(this.products);
}
