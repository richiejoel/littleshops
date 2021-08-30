import 'package:flutter/material.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/data/model/order_model.dart';
import 'package:littleshops/presentation/widgets/others/custom_card_widget.dart';
import 'package:littleshops/presentation/widgets/others/text_row.dart';
import 'package:littleshops/utils/fomatter.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:littleshops/utils/app_extension.dart';

class OrderModelCard extends StatelessWidget {
  final OrderModel order;

  const OrderModelCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.DETAIL_ORDER,
          arguments: order,
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Delivery status
                Text.rich(
                  TextSpan(
                    style: FONT_CONST.REGULAR_DEFAULT_16,
                    children: [
                      TextSpan(
                        text: !order.isDelivered
                            ? Translate.of(context).translate("be_delivering")
                            : Translate.of(context).translate("delivered"),
                        style: FONT_CONST.BOLD_PRIMARY_16,
                      ),
                      if ("because" == "why")
                        TextSpan(
                          text:
                          " (${UtilFormatter.formatTimeStamp(order.receivedDate)})",
                        ),
                    ],
                  ),
                ),

                // Price to be paid and payment method
                TextRow(
                    title: Translate.of(context).translate("total"),
                    content:
                    "${order.priceToBePaid.toPrice()} (${order.paymentMethod})"),

                // Number of items
                TextRow(
                  title: Translate.of(context).translate("quantity"),
                  content:
                  "${order.items.length} ${Translate.of(context).translate("item")}",
                ),

                // Created at
                TextRow(
                  title: Translate.of(context).translate("created_at"),
                  content: UtilFormatter.formatTimeStamp(order.createdAt),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}