import 'package:flutter/material.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';

import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/add_to_cart.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/benefits.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/product_images.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/product_info.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/related_products/related_products.dart';
import 'package:littleshops/presentation/widgets/buttons/cart_button.dart';

class DetailProductScreen extends StatelessWidget {
  final Product product;

  DetailProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("Little Shops", style: FONT_CONST.TITLE_APPBAR,),
          backgroundColor: COLOR_CONST.primaryColor,
          actions: [
            CartButton(color: COLOR_CONST.whiteColor),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.message, color: Colors.white,),
            ),
          ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            //DetailProductAppBar(),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ProductImagesWidget(product: product),
                  ProductInfoWidget(product: product),
                  Benefits(),
                  RelatedProducts(product: product),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: AddToCartNavigation(product: product),
    );
  }
}
