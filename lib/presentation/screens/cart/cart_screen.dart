import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_bloc.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_event.dart';
import 'package:littleshops/presentation/screens/cart/widgets/checkout_bottom.dart';
import 'package:littleshops/presentation/screens/cart/widgets/list_cart_item.dart';
import 'package:littleshops/utils/dialog.dart';
import 'package:littleshops/utils/translate.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListCartItemModel(),
      bottomNavigationBar: CheckoutBottom(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(Translate.of(context).translate("cart"), style: TextStyle(color: Colors.white),),
      actions: [
        IconButton(
          icon: Icon(Icons.clear_all_rounded, color: Colors.white,),
          onPressed: () => _onClearCart(context),
        )
      ],
    );
  }

  _onClearCart(BuildContext context) async {
    final response = await UtilDialog.showConfirmation(
      context,
      title: Translate.of(context).translate("clear_cart"),
      content: Text(
        Translate.of(context)
            .translate("all_cart_items_will_be_deleted_from_your_cart"),
        style: FONT_CONST.REGULAR_DEFAULT_20,
      ),
      confirmButtonText: Translate.of(context).translate("delete"),
    ) as bool;

    if (response) {
      BlocProvider.of<CartBloc>(context).add(ClearCart());
    }
  }
}