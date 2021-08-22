import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:littleshops/data/model/order_model.dart';

import 'order_repository_abstract.dart';

class OrderRepository implements IOrderRepository {
  var orderCollection = FirebaseFirestore.instance.collection("orders");

  /// Get all cart items
  Future<List<OrderModel>> fetchOrders(String uid) async {
    return orderCollection
        .where("uid", isEqualTo: uid)
        .get()
        .then((snapshot) => snapshot.docs.map((doc) {
      var data = doc.data()!;
      return OrderModel.fromMap(data);
    }).toList());
  }

  @override
  Future<void> addOrderModel(OrderModel newOrderModel) async {
    await orderCollection.doc(newOrderModel.id).set(newOrderModel.toMap());
  }

  @override
  Future<void> removeOrderModel(OrderModel order) async {
    await orderCollection.doc(order.id).delete();
  }

  @override
  Future<OrderModel> getOrderById(String pid) async {
    return await orderCollection
        .doc(pid)
        .get()
        .then((doc) => OrderModel.fromMap(doc.data()!))
        .catchError((error) {});
  }

  ///Singleton factory
  static final OrderRepository _instance =
  OrderRepository._internal();

  factory OrderRepository() {
    return _instance;
  }

  OrderRepository._internal();
}