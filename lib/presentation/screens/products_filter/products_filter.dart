import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/presentation/screens/home_page/bloc/home_bloc.dart';
import 'package:littleshops/presentation/screens/home_page/bloc/home_event.dart';
import 'package:littleshops/presentation/screens/home_page/bloc/home_state.dart';
import 'package:littleshops/presentation/widgets/buttons/cart_button.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/presentation/widgets/others/section_widget.dart';
import 'package:littleshops/presentation/widgets/others/section_widget_grid.dart';
import 'package:littleshops/presentation/widgets/single_card/product_card.dart';
import 'package:littleshops/utils/translate.dart';

import '../../../navigation_drawer.dart';

class ProductFilterScreen extends StatefulWidget{

  final BusinessModel business;
  ProductFilterScreen({Key? key, required this.business}) : super(key: key);

  @override
  _ProductFilterScreenState createState() => _ProductFilterScreenState(business: business);
}

class _ProductFilterScreenState extends State<ProductFilterScreen>{

  final BusinessModel business;
  _ProductFilterScreenState({required this.business});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc()..add(LoadHomeBusiness(businessID: business.id)),
        child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset : false,
            appBar: _buildAppBar(context),
            body: Container(
              child: RefreshIndicator(
                color: COLOR_CONST.primaryColor,
                onRefresh: () async {
                  BlocProvider.of<HomeBloc>(context).add(RefreshProductByBusiness(businessID: business.id));
                },
                child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: [
                    _buildBody(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  ///SliverToBoxAdapter
  _buildBody (BuildContext context){
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoadedBusiness) {
            var productsByBusiness = homeState.productsByBusiness;
            return SingleChildScrollView(
              child: Column(
                  children:[
                    _buildProductsByBusiness(context, productsByBusiness),
                  ]
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

  _buildProductsByBusiness (BuildContext context, List<Product> productsByBusiness) {
    return SectionWidgetGrid(
      title: business.name,
      children: productsByBusiness.map((p) => ProductCard(product: p)).toList(),
    );
  }

  _buildAppBar(BuildContext context){
    return AppBar(
      title: Text("Little Shops", style: FONT_CONST.TITLE_APPBAR,),
      backgroundColor: COLOR_CONST.primaryColor,
      actions: [
        CartButton(color: COLOR_CONST.whiteColor),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.message, color: Colors.white,),
        ),
      ],
    );
  }

}