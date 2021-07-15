import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/icon_constant.dart';
import 'package:littleshops/data/model/cart_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_bloc.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_event.dart';
import 'package:littleshops/presentation/widgets/buttons/circle_icon_button.dart';
import 'package:littleshops/presentation/widgets/others/custom_card_widget.dart';
import 'package:littleshops/presentation/widgets/others/shimmer_image.dart';
import 'package:littleshops/utils/app_extension.dart';

class CartItemModelCard extends StatelessWidget {
  const CartItemModelCard({
    Key? key,
    required this.cartItem,
    this.allowChangeQuantity = true,
  }) : super(key: key);

  final CartModel cartItem;
  final bool allowChangeQuantity;

  @override
  Widget build(BuildContext context) {
    var product = cartItem.productInfo!;

    return CustomCardWidget(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.DETAIL_PRODUCT,
        arguments: product,
      ),
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize * 0.5,
        horizontal: SizeConfig.defaultSize,
      ),
      padding: EdgeInsets.only(right: SizeConfig.defaultSize),
      child: Row(
        children: [
          _buildCartItemModelImage(product),
          SizedBox(width: SizeConfig.defaultSize),
          Expanded(child: _buildCartItemModelInfo(product, context)),
        ],
      ),
    );
  }

  _buildCartItemModelImage(Product product) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 0.5),
      child: ShimmerImage(
        imageUrl: product.images[0],
        width: SizeConfig.defaultSize * 13,
        height: SizeConfig.defaultSize * 13,
      ),
    );
  }

  _buildCartItemModelInfo(Product product, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Product Name
        Text(
          "${product.name}",
          style: FONT_CONST.MEDIUM_DEFAULT_16,
          maxLines: 1,
        ),

        // Cart item price
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "${product.price.toPrice()}",
            style: FONT_CONST.REGULAR_PRIMARY_18,
          ),
        ),

        allowChangeQuantity
            ? _buildCartItemModelQuantity(product, context)
            : Text("x ${cartItem.quantity}")
      ],
    );
  }

  _buildCartItemModelQuantity(Product product, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrease button
        CircleIconButton(
          svgIcon: ICON_CONST.SUBTRACT,
          color: Color(0xFFF5F6F9),
          size: SizeConfig.defaultSize * 1.2,
          onPressed: cartItem.quantity > 1
              ? () => _onChangeQuantity(context, product, cartItem.quantity - 1)
              : () {},
        ),

        // Quantity
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
          child: Text("${cartItem.quantity}", style: FONT_CONST.BOLD_DEFAULT),
        ),

        // Increase button
        CircleIconButton(
          svgIcon: ICON_CONST.ADD,
          color: Color(0xFFF5F6F9),
          size: SizeConfig.defaultSize * 1.2,
          onPressed: cartItem.quantity < product.quantity
              ? () => _onChangeQuantity(context, product, cartItem.quantity + 1)
              : () {},
        )
      ],
    );
  }

  _onChangeQuantity(BuildContext context, Product product, int newQuantity) {
    // update cart item
    BlocProvider.of<CartBloc>(context).add(UpdateCartItemModel(
      cartItem.cloneWith(
        quantity: newQuantity,
        price: newQuantity * product.price,
      ),
    ));
  }
}