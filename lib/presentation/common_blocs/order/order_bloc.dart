import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/data/model/order_model.dart';
import 'package:littleshops/data/model/push_notification_model.dart';
import 'package:littleshops/data/repository/auth/auth_repository.dart';
import 'package:littleshops/data/repository/order_repository/order_repository.dart';
import 'package:littleshops/data/repository/product_repository/product_repository.dart';
import 'package:littleshops/data/repository/push_repository/push_repository.dart';

import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository _orderRepository = OrderRepository();
  AuthRepository _authRepository = AuthRepository();
  PushRepository _pushRepository = PushRepository();
  ProductRepository _productRepository = ProductRepository();
  OrderBloc() : super(MyOrdersLoading());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is LoadMyOrders) {
      yield* _mapLoadMyOrdersToState(event);
    } else if (event is AddOrder) {
      yield* _mapAddOrderToState(event);
    } else if (event is RemoveOrder) {
      yield* _mapRemoveOrderToState(event);
    } else if( event is ApproveOrder){
      yield* _mapApproveOrderToState(event);
    }
  }

  Stream<OrderState> _mapLoadMyOrdersToState(
      LoadMyOrders event) async* {
    try {
      var loggedFirebaseUser = _authRepository.loggedFirebaseUser;
      List<OrderModel> orders =
      await _orderRepository.fetchOrders(loggedFirebaseUser.uid);

      // Classify orders
      List<OrderModel> deliveringOrders = [];
      List<OrderModel> deliveredOrders = [];

      orders.forEach((order) {
        if (!order.isDelivered) {
          deliveringOrders.add(order);
        } else {
          deliveredOrders.add(order);
        }
      });
      yield MyOrdersLoaded(
        deliveringOrders: deliveringOrders,
        deliveredOrders: deliveredOrders,
      );
    } catch (e) {
      yield MyOrdersLoadFailure(e.toString());
    }
  }

  Stream<OrderState> _mapAddOrderToState(AddOrder event) async* {
    try {
      PushNotificationModel pushNotificationModel = PushNotificationModel
        (businessId: "", messageBody: "Tienes un nuevo pedido ",
          push: "PUSH", title: "Little Shops te informa", orderId: "", userLoggedId: "");

      var newOrderModel = event.newOrderModel
          .cloneWith(uid: _authRepository.loggedFirebaseUser.uid);

      await _orderRepository.addOrderModel(newOrderModel);

      List<String> businesses = [];
      String business;

      for(int i=0; i < newOrderModel.items.length; i++){
        business = await _productRepository
            .fetchChiefByProductId(newOrderModel.items.elementAt(i).productId);
        if(businesses.length > 0){
          for(int j =0; j < businesses.length; j++){
            if(business != businesses.elementAt(j)){
              businesses.add(business);
            }
          }
        } else {
          businesses.add(business);
        }
      }

      for(int k=0; k < businesses.length; k++) {
        PushNotificationModel modelPush = pushNotificationModel.cloneWith(
            title: "Little Shops te informa" ,
            messageBody: "Tienes un nuevo pedido esperando ser completado",
            push: "PUSH",
            businessId: businesses.elementAt(k),
            orderId: event.newOrderModel.id,
            userLoggedId: _authRepository.loggedFirebaseUser.uid,
        );
        await _pushRepository.generateNotificationPush(modelPush);
      }



    } catch (e) {
      print(e.toString());
    }
  }

  Stream<OrderState> _mapRemoveOrderToState(
      RemoveOrder event) async* {
    try {
      await _orderRepository.removeOrderModel(event.order);
      add(LoadMyOrders());
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<OrderState> _mapApproveOrderToState(
      ApproveOrder event) async* {
    try {
       _orderRepository.updateOneDataOrder(event.orderID, event.key, event.value);
      //add(LoadMyOrders());
    } catch (e) {
      print(e.toString());
    }
  }

}