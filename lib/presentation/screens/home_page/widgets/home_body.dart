import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/router.dart';

import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/presentation/widgets/others/section_widget.dart';
import 'package:littleshops/presentation/widgets/single_card/category_card.dart';
import 'package:littleshops/presentation/widgets/single_card/product_card.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:littleshops/presentation/screens/home_page/bloc/home_bloc.dart';
import 'package:littleshops/presentation/screens/home_page/bloc/home_state.dart';
import 'package:littleshops/presentation/screens/home_page/widgets/home_banner.dart';

//#3084ee color notificarion
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoaded) {
            var homeResponse = homeState.homeResponse;
            return SingleChildScrollView(
              child: Column(
                children: [
                  HomeBanner(banners: homeResponse.banners),
                  _buildHomeCategories(
                    context,
                    homeResponse.categories,
                  ),
                  //PromoWidget(),
                  _buildPopularProducts(
                    context,
                    homeResponse.popularProducts,
                  ),
                  _buildDiscountProducts(
                    context,
                    homeResponse.discountProducts,
                  ),
                ],
              ),
            );
          }
          if (homeState is HomeLoading) {
            return Loading();
          }
          if (homeState is HomeLoadFailure) {
            return Center(child: Text(homeState.error));
          }
          return Center(child: Text("Something went wrong."));
        },
      ),
    );
  }

  _buildPopularProducts(BuildContext context, List<Product> popularProducts) {
    return SectionWidget(
      title: Translate.of(context).translate('popular_products'),
      children: popularProducts.map((p) => ProductCard(product: p)).toList(),
    );
  }

  _buildDiscountProducts(BuildContext context, List<Product> discountProducts) {
    return SectionWidget(
      title: Translate.of(context).translate('discount_products'),
      children: discountProducts.map((p) => ProductCard(product: p)).toList(),
    );
  }

  _buildHomeCategories(BuildContext context, List<CategoryModel> categories) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultPadding),
      child: GridView.builder(
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio: 931 / 485,
        ),
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categories[index],
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRouter.FAVOURITE,
                arguments: categories[index],
              );
            },
          );
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}