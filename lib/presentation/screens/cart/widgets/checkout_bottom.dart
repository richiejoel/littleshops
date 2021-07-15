import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/icon_constant.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_bloc.dart';
import 'package:littleshops/presentation/common_blocs/cart/cart_state.dart';
import 'package:littleshops/presentation/widgets/buttons/default_button.dart';
import 'package:littleshops/utils/dialog.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:littleshops/utils/app_extension.dart';

class CheckoutBottom extends StatelessWidget {
  const CheckoutBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -0.5),
              color: Colors.black12,
              blurRadius: 5,
            )
          ],
        ),
        child: BlocBuilder<CartBloc, CartState>(
          buildWhen: (preState, currState) => currState is CartLoaded,
          builder: (context, state) {
            if (state is CartLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTotalPrice(context, state),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildCheckoutButton(context, state),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  _buildCheckoutButton(BuildContext context, CartLoaded state) {
    return DefaultButton(
      child: Text(
        Translate.of(context).translate("check_out"),
        style: FONT_CONST.BOLD_WHITE_18,
      ),
      onPressed: () {
        if (state.cart.length > 0) {
          //_openPaymentBottomSheet(context);
        } else {
          UtilDialog.showInformation(
            context,
            content: Translate.of(context).translate("your_cart_is_empty"),
          );
        }
      },
    );
  }

  _buildTotalPrice(BuildContext context, CartLoaded state) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: SizeConfig.defaultSize * 5,
          width: SizeConfig.defaultSize * 5,
          decoration: BoxDecoration(
            color: COLOR_CONST.cardShadowColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(SizeConfig.defaultSize),
          ),
          child: Icon(
            ICON_CONST.RECEIPT,
            size: SizeConfig.defaultSize * 3.4,
            color: COLOR_CONST.discountColor,
          )
        ),
        SizedBox(width: SizeConfig.defaultSize),
        Text.rich(
          TextSpan(
            style: FONT_CONST.BOLD_DEFAULT_18,
            children: [
              TextSpan(text: Translate.of(context).translate("total") + ":\n"),
              TextSpan(
                text: "${state.priceOfGoods.toPrice()}",
                style: FONT_CONST.BOLD_PRIMARY_20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*_openPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) => PaymentBottomSheet(),
    );
  }*/
}