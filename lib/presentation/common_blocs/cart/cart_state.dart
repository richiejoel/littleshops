import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/cart_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

/// Carrito cargando
class CartLoading extends CartState {}

/// Carrito fue cargado
class CartLoaded extends CartState {
  final List<CartModel> cart;
  final double priceOfGoods;

  CartLoaded({
    required this.cart,
    required this.priceOfGoods,
  });

  @override
  List<Object> get props => [cart, priceOfGoods];
}

/// Carrito no fue cargado
class CartLoadFailure extends CartState {
  final String error;

  CartLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}