import 'package:flutter/material.dart';
import 'package:littleshops/presentation/widgets/others/text_row.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:littleshops/utils/app_extension.dart';

import 'custom_card_widget.dart';

class PaymentFeesWidget extends StatelessWidget {
  final double priceOfGoods;
  final double deliveryFee;
  final double coupon;
  final double priceToBePaid;

  const PaymentFeesWidget({
    Key? key,
    required this.priceOfGoods,
    required this.deliveryFee,
    required this.coupon,
    required this.priceToBePaid,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextRow(
            title: Translate.of(context).translate("total"),
            content: priceToBePaid.toPrice(),
            isSpaceBetween: true,
          ),
          TextRow(
            title: Translate.of(context).translate("price_of_goods"),
            content: priceOfGoods.toPrice(),
          ),
          TextRow(
            title: Translate.of(context).translate("delivery_fee"),
            content: deliveryFee.toPrice(),
          ),
          TextRow(
            title: Translate.of(context).translate("coupon"),
            content: coupon.toPrice(),
          ),
        ],
      ),
    );
  }
}