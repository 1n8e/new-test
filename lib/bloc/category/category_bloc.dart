import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:new_test/datasources/category_datasource.dart';
import 'package:new_test/datasources/product_datasource.dart';
import 'package:new_test/models/category_model.dart';
import 'package:new_test/models/product_model.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryDatasource categoryDatasource;
  final ProductDatasource productDatasource;
  final Box tokens;

  CategoryBloc(this.categoryDatasource, this.tokens, this.productDatasource)
      : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategoryEvent) {
      yield CategoryLoading();
      try {
        await tokens.get('access');
        await tokens.get('refresh');
        final List<Category> categories =
            await categoryDatasource.getCategory();
        yield CategorySuccess(categories);
      } catch (e) {
        yield CategoryFailure(e.toString());
      }
    } else if (event is GetProductEvent) {
      yield CategoryLoading();
      try {
        await tokens.get('access');
        await tokens.get('refresh');
        final List<Product> products = await productDatasource.getProduct();
        yield ProductSuccess(products);
      } catch (e) {
        yield CategoryFailure(e.toString());
      }
    } else if (event is SearchProductEvent) {
      yield CategoryLoading();
      try {
        final List<Product> products =
            await productDatasource.getFilteredProducts(event.filter);
        yield FilteredProductState(products);
      } catch (e) {
        yield CategoryFailure(e.toString());
      }
    }
  }
}
