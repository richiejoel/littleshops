import 'package:flutter/material.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/presentation/widgets/others/shimmer_image.dart';
import 'package:littleshops/utils/translate.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
    this.onPressed,
  }) : super(key: key);

  final CategoryModel category;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          ShimmerImage(
            borderRadius: BorderRadius.circular(5),
            imageUrl: category.imageUrl,
          ),
          Positioned(
            bottom: SizeConfig.defaultSize,
            left: SizeConfig.defaultSize * 2,
            child: Text(
              Translate.of(context).translate("${category.name}"),
              style: FONT_CONST.CATEGORY_TEXT, //BOLD_WHITE_20
            ),
          ),
        ],
      ),
    );
  }
}