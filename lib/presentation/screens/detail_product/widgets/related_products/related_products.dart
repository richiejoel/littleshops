import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:littleshops/configs/router.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/presentation/widgets/others/section_widget.dart';
import 'package:littleshops/presentation/widgets/single_card/product_card.dart';
import 'package:littleshops/utils/translate.dart';
import 'bloc/related_products_bloc.dart';
import 'bloc/related_products_event.dart';
import 'bloc/related_products_state.dart';

class RelatedProducts extends StatelessWidget {
  final Product product;

  const RelatedProducts({Key? key, required this.product}) : super(key: key);

  void _onSeeAll(BuildContext context) {
    BlocProvider.of<RelatedProductsBloc>(context)
        .add(OnSeeAll(product.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      RelatedProductsBloc()..add(LoadRelatedProducts(product)),
      child: BlocConsumer<RelatedProductsBloc, RelatedProductsState>(
        listenWhen: (preState, currState) => currState is GoToCategoriesScreen,
        listener: (context, state) {
          if (state is GoToCategoriesScreen) {
            Navigator.pushNamed(
              context,
              AppRouter.FAVOURITE, //Categories
              arguments: state.category,
            );
          }
        },
        buildWhen: (preState, currState) => currState is! GoToCategoriesScreen,
        builder: (context, state) {
          if (state is RelatedProductsLoading) {
            return Loading();
          }
          if (state is RelatedProductsLoadFailure) {
            return Center(child: Text("Loading Failure"));
          }
          if (state is RelatedProductsLoaded) {
            return SectionWidget(
              title: Translate.of(context).translate('related_products'),
              children: state.relatedProducts
                  .map((p) => ProductCard(product: p))
                  .toList(),
              handleOnSeeAll: () => _onSeeAll(context),
            );
          }
          return Center(child: Text("Unknown state"));
        },
      ),
    );
  }
}