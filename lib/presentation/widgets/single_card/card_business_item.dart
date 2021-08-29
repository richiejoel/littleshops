import 'package:flutter/material.dart';

import 'package:littleshops/configs/router.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/presentation/widgets/others/custom_card_widget.dart';
import 'package:littleshops/presentation/widgets/others/shimmer_image.dart';


class CartItemBusinessCard extends StatelessWidget {
  const CartItemBusinessCard({
    Key? key,
    required this.businessItem
  }) : super(key: key);

  final BusinessModel businessItem;


  @override
  Widget build(BuildContext context) {
    var businessId = businessItem.id;

    return CustomCardWidget(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.PRODUCTS_BY_BUSINESS,
        arguments: businessItem,
      ),
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize * 0.5,
        horizontal: SizeConfig.defaultSize,
      ),
      padding: EdgeInsets.only(right: SizeConfig.defaultSize),
      child: Row(
        children: [
          _buildBusinessItemModelImage(businessItem),
          SizedBox(width: SizeConfig.defaultSize),
          Expanded(child: _buildBusinessItemModelInfo(businessItem, context)),
        ],
      ),
    );
  }

  _buildBusinessItemModelImage(BusinessModel businessModel) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 0.5),
      child: ShimmerImage(
        imageUrl: businessModel.imageUrl,
        width: SizeConfig.defaultSize * 13,
        height: SizeConfig.defaultSize * 13,
      ),
    );
  }

  _buildBusinessItemModelInfo(BusinessModel businessModel, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Product Name
        Text(
          "${businessModel.name}",
          style: FONT_CONST.MEDIUM_DEFAULT_16,
          maxLines: 4,
        ),

        // Description business
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "${businessModel.description}",
            style: FONT_CONST.REGULAR_PRIMARY_18,
          ),
        ),
      ],
    );
  }

}