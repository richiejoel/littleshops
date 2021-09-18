import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/image_constants.dart';
import 'package:littleshops/presentation/common_blocs/business/bloc.dart';
import 'package:littleshops/presentation/widgets/buttons/cart_button.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/presentation/widgets/single_card/card_business_item.dart';

class ShopsScreen extends StatefulWidget{
  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen>{

  @override
  void initState() {
    BlocProvider.of<BusinessBloc>(context).add(LoadBusiness());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: _builderBody(context),
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

  _builderBody(BuildContext context){

    return BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state) {
          if(state is BusinessLoaded ){
            var business = state.allBusiness;
            return SafeArea(
              child: business.length > 0
                  ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: business.length,
                itemBuilder: (context, index) {
                  return CartItemBusinessCard(
                     businessItem: business[index],
                  );
                },

              ) : Center(
                  child: Image.asset(
                    IMAGE_CONSTANT.CART_EMPTY,
                    width: SizeConfig.defaultSize * 20,
                  )),
            );
          }

          if (state is BusinessLoading) {
            return Scaffold(
              body: Container(
                color: COLOR_CONST.backgroundColor,
                child: Loading(),
              ),
            );
          }

          return Center(child: Text("Something went wrong."));
        }
    );
  }

}