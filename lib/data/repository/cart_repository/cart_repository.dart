import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:littleshops/data/model/cart_model.dart';

import 'cart_repository_abstract.dart';

/// cart is collection in each user
class CartRepository implements ICartRepository {
  var userCollection = FirebaseFirestore.instance.collection("users");

  /// Get all cart items
  Stream<List<CartModel>> fetchCart(String uid) {
    return userCollection
        .doc(uid)
        .collection("cart")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      var data = doc.data()!;
      return CartModel.fromMap(data);
    }).toList());
  }

  /// Add item
  Future<void> addCartItemModel(String uid, CartModel newItem) async {
    var userRef = userCollection.doc(uid);
    await userRef.collection("cart").doc(newItem.id).get().then((doc) async {
      if (doc.exists) {
        // old data + new data
        var quantity = doc.data()!["quantity"] + newItem.quantity;
        var price = doc.data()!["price"] + newItem.price;
        double priceDB = double.parse(price.toStringAsFixed(2));
        // update
        await doc.reference.update({"quantity": quantity, "price": priceDB });
      } else {
        // add new
        await doc.reference.set(newItem.toMap());
        print("success");
      }
    }).catchError((error) {
      print(error);
    });
  }

  /// Remove item
  Future<void> removeCartItemModel(String uid, CartModel cartItem) async {
    await userCollection
        .doc(uid)
        .collection("cart")
        .doc(cartItem.id)
        .delete()
        .catchError((error) => print(error));
  }

  /// Clear cart
  Future<void> clearCart(String uid) async {
    await userCollection
        .doc(uid)
        .collection("cart")
        .get()
        .then((snapshot) async {
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }).catchError((error) {});
  }

  /// Update quantity of cart item
  Future<void> updateCartItemModel(String uid, CartModel cartItem) async {
    var userRef = userCollection.doc(uid);
    await userRef.collection("cart").doc(cartItem.id).get().then((doc) async {
      if (doc.exists) {
        // update
        await doc.reference.update(cartItem.toMap());
      }
    }).catchError((error) {
      print(error);
    });
  }

  ///Singleton factory
  static final CartRepository _instance =
  CartRepository._internal();

  factory CartRepository() {
    return _instance;
  }

  CartRepository._internal();
}