import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';

class CircleIconButton extends StatelessWidget {
  final double size;
  final Function? onPressed;
  final String svgIcon;
  final Color color;

  const CircleIconButton({
    Key? key,
    required this.size,
    required this.svgIcon,
    this.onPressed,
    this.color = COLOR_CONST.discountColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as void Function()?,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          svgIcon,
          width: size,
          height: size,
        ),
      ),
    );
  }
}