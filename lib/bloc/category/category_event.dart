part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetCategoryEvent extends CategoryEvent {}

class GetProductEvent extends CategoryEvent {}

class SearchProductEvent extends CategoryEvent {
  final String filter;

  SearchProductEvent(this.filter);

}