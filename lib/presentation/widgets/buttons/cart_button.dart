import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/icon_constant.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_bloc.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_state.dart';

import 'icon_button_counter.dart';

class CartButton extends StatelessWidget {
  final Color color;

  const CartButton({
    Key? key,
    this.color = COLOR_CONST.textColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (prevState, currState) => currState is CartLoaded,
        builder: (context, state) {
          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child:  IconButtonWithCounter(
                icon: ICON_CONST.CART,
                onPressed: () => Navigator.pushNamed(context, AppRouter.CART),
                counter: state is CartLoaded ? state.cart.length : 0,
                size: SizeConfig.defaultSize * 3.0,
                color: color,
              ),
            ),
          );

        });
  }
}