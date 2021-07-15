import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/image_constants.dart';
import 'package:littleshops/data/model/cart_model.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_bloc.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_event.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_state.dart';
import 'package:littleshops/presentation/widgets/others/custom_dismissible.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/presentation/widgets/single_card/cart_item_cart.dart';

class ListCartItemModel extends StatelessWidget {
  void _onDismissed(BuildContext context, CartModel cartItem) {
    BlocProvider.of<CartBloc>(context).add(RemoveCartItemModel(cartItem));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Loading();
        }
        if (state is CartLoaded) {
          var cart = state.cart;
          return SafeArea(
            child: cart.length > 0
                ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cart.length + 1,
              itemBuilder: (context, index) {
                if (index == cart.length) {
                  return Text("");
                }
                return CustomDismissible(
                  key: Key(cart[index].id),
                  onDismissed: (direction) {
                    _onDismissed(context, cart[index]);
                  },
                  removeIcon: Icon(Icons.remove_shopping_cart),
                  child: CartItemModelCard(cartItem: cart[index]),
                );
              },
            )
                : Center(
                child: Image.asset(
                  IMAGE_CONSTANT.CART_EMPTY,
                  width: SizeConfig.defaultSize * 20,
                )),
          );
        }
        if (state is CartLoadFailure) {
          return Center(child: Text("Load failure"));
        }
        return Center(child: Text("Something went wrong."));
      },
    );
  }
}
