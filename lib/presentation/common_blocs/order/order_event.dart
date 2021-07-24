import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/order_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadMyOrders extends OrderEvent {}

class AddOrder extends OrderEvent {
  final OrderModel newOrderModel;

  AddOrder(this.newOrderModel);

  List<Object> get props => [newOrderModel];
}

class RemoveOrder extends OrderEvent {
  final OrderModel order;

  RemoveOrder(this.order);

  List<Object> get props => [order];
}