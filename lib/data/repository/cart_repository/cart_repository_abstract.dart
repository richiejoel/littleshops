import 'package:littleshops/data/model/cart_model.dart';

abstract class ICartRepository {
  /// Cart stream
  /// [uid] is user id
  Stream<List<CartModel>> fetchCart(String uid);

  /// Add item
  /// [uid] is user id
  /// [newItem] is data of new cart item
  Future<void> addCartItemModel(String uid, CartModel newItem);

  /// Remove item
  /// [uid] is user id
  /// [cartItem] is data of cart item
  Future<void> removeCartItemModel(String uid, CartModel cartItem);

  /// Clear cart
  /// [uid] is user id
  Future<void> clearCart(String uid);

  /// Update quantity
  /// [uid] is user id
  /// [cartItem] is updated data of cart item
  Future<void> updateCartItemModel(String uid, CartModel cartItem);
}