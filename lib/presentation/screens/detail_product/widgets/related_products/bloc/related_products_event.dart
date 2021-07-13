import 'package:equatable/equatable.dart';

import 'package:littleshops/data/model/product_model.dart';

abstract class RelatedProductsEvent extends Equatable {
  const RelatedProductsEvent();
}

/// Cuando el usuario da click a un producto en especifico => load related products
class LoadRelatedProducts extends RelatedProductsEvent {
  final Product product;

  LoadRelatedProducts(this.product);

  @override
  List<Object> get props => [product];
}

class OnSeeAll extends RelatedProductsEvent {
  final String categoryId;

  OnSeeAll(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
