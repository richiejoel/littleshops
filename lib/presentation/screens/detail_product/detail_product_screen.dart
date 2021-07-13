import 'package:flutter/material.dart';

import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/add_to_cart.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/benefits.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/product_images.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/product_info.dart';
import 'package:littleshops/presentation/screens/detail_product/widgets/related_products/related_products.dart';

class DetailProductScreen extends StatelessWidget {
  final Product product;

  DetailProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
