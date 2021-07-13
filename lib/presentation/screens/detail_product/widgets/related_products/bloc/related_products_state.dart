import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/product_model.dart';

abstract class RelatedProductsState extends Equatable {
  const RelatedProductsState();
}

/// Cuando abre la pantalla detalle producto => loading related products state
class RelatedProductsLoading extends RelatedProductsState {
  @override
  List<Object> get props => [];
}

/// Cuando porductos relacionados fue cargado => related products loaded state
class RelatedProductsLoaded extends RelatedProductsState {
  final List<Product> relatedProducts;

  RelatedProductsLoaded(this.relatedProducts);
  @override
  List<Object> get props => [relatedProducts];
}

/// Cuando porductos relacionados no fue cargado => related products not loaded state
class RelatedProductsLoadFailure extends RelatedProductsState {
  final String error;

  RelatedProductsLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}

class GoToCategoriesScreen extends RelatedProductsState {
  final CategoryModel category;

  GoToCategoriesScreen(this.category);
  @override
  List<Object> get props => [category];
}