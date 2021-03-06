import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/router.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/util_constants.dart';
import 'package:littleshops/data/model/order_model.dart';
import 'package:littleshops/presentation/common_blocs/order/order_bloc.dart';
import 'package:littleshops/presentation/common_blocs/order/order_event.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_bloc.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_state.dart';
import 'package:littleshops/presentation/widgets/buttons/default_button.dart';
import 'package:littleshops/presentation/widgets/others/custom_card_widget.dart';
import 'package:littleshops/presentation/widgets/others/custom_list_tile.dart';
import 'package:littleshops/presentation/widgets/others/payment_fees_widget.dart';
import 'package:littleshops/presentation/widgets/others/shimmer_image.dart';
import 'package:littleshops/presentation/widgets/others/text_row.dart';
import 'package:littleshops/presentation/widgets/single_card/delivery_address_card.dart';
import 'package:littleshops/utils/fomatter.dart';
import 'package:littleshops/utils/toast.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:littleshops/utils/app_extension.dart';

class DetailOrderScreen extends StatelessWidget {
  final OrderModel order;

  const DetailOrderScreen({Key? key, required this.order}) : super(key: key);

  void _onCancelOrderModel(BuildContext context) {
    // Add remove order event
    BlocProvider.of<OrderBloc>(context).add(RemoveOrder(order));

    // Show toast:  Cancel successfully
    UtilToast.showMessageForUser(
      context,
      Translate.of(context).translate("cancel_successfully"),
    );

    Navigator.pushNamed(
      context,
      AppRouter.HOME,
    );
    // Pop this screen
    //Navigator.pop(context);
  }

  void _onApproveOrderModel(BuildContext context) {
    // Add remove order event
    BlocProvider.of<OrderBloc>(context).add(ApproveOrder(order.id, "isDelivered", true));

    // Show toast:  Cancel successfully
    UtilToast.showMessageForUser(
      context,
      Translate.of(context).translate("delivery_successfully"),
    );

    Navigator.pushNamed(
      context,
      AppRouter.HOME,
    );
    // Pop this screen
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if(state is ProfileLoaded){
            return Scaffold(
              backgroundColor: COLOR_CONST.backgroundColor,
              appBar: AppBar(
                  title: Text(
                    Translate.of(context).translate("detail_order"),
                    style: FONT_CONST.TITLE_DRAWER,
                  )
              ),
              body: SafeArea(
                child: ListView(
                  padding: EdgeInsets.only(bottom: SizeConfig.defaultPadding),
                  children: [
                    _buildListOrderModelItems(),
                    PaymentFeesWidget(
                      priceOfGoods: order.priceOfGoods,
                      deliveryFee: order.deliveryFee,
                      coupon: order.coupon,
                      priceToBePaid: order.priceToBePaid,
                    ),
                    _buildPaymentMethod(context),
                    DeliveryAddressCard(
                      deliveryAddress: order.deliveryAddress,
                      showDefautTick: false,
                    ),
                    _buildDelivering(context),
                    if (state.loggedUser.role == UTIL_CONST.COURIER) ... [
                      _buildApproveDeliveryButton(context)
                    ],
                    const SizedBox(height: 7,),
                    if (state.loggedUser.role == UTIL_CONST.CUSTOMER ||
                        state.loggedUser.role == UTIL_CONST.CHIEF) ... [
                      _buildRemoveButton(context)
                    ],
                  ],
                ),
              ),
            );
          }
          return Center(child: Text("Something went wrongs."));
        }
    );
  }

  _buildDelivering(BuildContext context) {
    return CustomCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !order.isDelivered
                ? Translate.of(context).translate("be_delivering")
                : Translate.of(context).translate("delivered"),
            style: FONT_CONST.BOLD_PRIMARY_18,
          ),
          TextRow(
            title: Translate.of(context).translate("created_at"),
            content: UtilFormatter.formatTimeStamp(order.createdAt),
          ),
        ],
      ),
    );
  }

  _buildPaymentMethod(BuildContext context) {
    return CustomCardWidget(
      child: TextRow(
        title: Translate.of(context).translate("payment_method"),
        content: order.paymentMethod,
        isSpaceBetween: true,
      ),
    );
  }

  _buildListOrderModelItems() {
    return CustomCardWidget(
      child: Column(
        children: List.generate(order.items.length, (index) {
          return CustomListTile(
            leading: ShimmerImage(imageUrl: order.items[index].productImage),
            subTitle: Text(
              "x ${order.items[index].quantity}",
              style: FONT_CONST.REGULAR_DEFAULT_16,
            ),
            title: order.items[index].productName,
            trailing: Text(
              "${order.items[index].productPrice.toPrice()}",
              style: FONT_CONST.REGULAR_DEFAULT_18,
            ),
            bottomBorder: false,
          );
        }),
      ),
    );
  }

  _buildRemoveButton(BuildContext context) {
    // Remove button only show when order is still in delivering time
    if (!order.isDelivered) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
        child: DefaultButton(
          onPressed: () => _onCancelOrderModel(context),
          child: Text(
            Translate.of(context).translate("cancel"),
            style: FONT_CONST.BOLD_WHITE_18,
          ),
          backgroundColor: COLOR_CONST.deleteButtonColor,
        ),
      );
    }
    return Container();
  }

  _buildApproveDeliveryButton(BuildContext context) {
    // Remove button only show when order is still in delivering time
    if (!order.isDelivered) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
        child: DefaultButton(
          onPressed: () => _onApproveOrderModel(context),
          child: Text(
            Translate.of(context).translate("complete_delivery"),
            style: FONT_CONST.BOLD_WHITE_18,
          ),
          backgroundColor: COLOR_CONST.deleteButtonColor,
        ),
      );
    }
    return Container();
  }

}

