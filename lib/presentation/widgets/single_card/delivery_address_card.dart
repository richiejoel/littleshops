import 'package:flutter/material.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/data/model/delivery_address_model.dart';
import 'package:littleshops/presentation/widgets/others/custom_card_widget.dart';
import 'package:littleshops/presentation/widgets/others/text_row.dart';
import 'package:littleshops/utils/translate.dart';

class DeliveryAddressCard extends StatelessWidget {
  final DeliveryAddressModel deliveryAddress;
  final Function()? onPressed;
  final bool showDefautTick;

  const DeliveryAddressCard({
    Key? key,
    required this.deliveryAddress,
    this.onPressed,
    this.showDefautTick = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                Translate.of(context).translate("delivery_address"),
                style: FONT_CONST.BOLD_PRIMARY_18,
              ),
              Spacer(),
              _buildDefaultText(context),
            ],
          ),
          TextRow(
            title: Translate.of(context).translate("name"),
            content: deliveryAddress.receiverName,
          ),
          TextRow(
            title: Translate.of(context).translate("phone_number"),
            content: deliveryAddress.phoneNumber,
          ),
          TextRow(
            title: Translate.of(context).translate("detail_address"),
            content: deliveryAddress.toString(),
          ),
        ],
      ),
    );
  }

  _buildDefaultText(BuildContext context) {
    return deliveryAddress.isDefault && showDefautTick
        ? Text(
      "[" + Translate.of(context).translate("default") + "]",
      style: FONT_CONST.REGULAR_PRIMARY,
    )
        : Container();
  }
}
