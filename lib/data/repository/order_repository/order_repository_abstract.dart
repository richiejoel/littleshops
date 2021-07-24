import 'package:littleshops/data/model/order_model.dart';

abstract class IOrderRepository {
  /// Get all orders
  /// [uid] is user id
  /// Created by NDH
  Future<List<OrderModel>> fetchOrders(String uid);

  /// Add item
  /// [newOrderModel] is data of new order
  /// Created by NDH
  Future<void> addOrderModel(OrderModel newOrderModel);

  /// Add item
  /// [newOrderModel] is data of new order
  /// Created by NDH
  Future<void> removeOrderModel(OrderModel order);
}