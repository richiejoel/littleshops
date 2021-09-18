import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/image_constants.dart';
import 'package:littleshops/data/model/order_model.dart';
import 'package:littleshops/navigation_drawer.dart';
import 'package:littleshops/presentation/common_blocs/order/order_bloc.dart';
import 'package:littleshops/presentation/common_blocs/order/order_event.dart';
import 'package:littleshops/presentation/common_blocs/order/order_state.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/presentation/widgets/single_card/order_card.dart';
import 'package:littleshops/utils/translate.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(LoadMyOrders());

    tabController = TabController(
      length: 2,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {
        currentTabIndex = tabController.index;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
          title: Text(
            Translate.of(context).translate("my_orders"),
            style: FONT_CONST.TITLE_DRAWER,
          ),
      ),
      body: SafeArea(child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is MyOrdersLoading) {
            return Loading();
          }
          if (state is MyOrdersLoaded) {
            return Column(
              children: <Widget>[
                _buildTabs(),
                SizedBox(height: SizeConfig.defaultSize),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      _buildListOrders(state.deliveringOrders),
                      _buildListOrders(state.deliveredOrders),
                    ],
                  ),
                )
              ],
            );
          }
          if (state is MyOrdersLoadFailure) {
            return Center(child: Text("Load Failure"));
          }
          return Center(child: Text("Something went wrongs."));
        },
      )),
    );
  }

  _buildTabs() {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        controller: tabController,
        tabs: <Widget>[
          Tab(text: Translate.of(context).translate("be_delivering")),
          Tab(text: Translate.of(context).translate("delivered")),
        ],
        onTap: (index) {},
        labelStyle: FONT_CONST.BOLD_PRIMARY_18,
        labelColor: COLOR_CONST.textColor,
        unselectedLabelColor: COLOR_CONST.textColor,
        unselectedLabelStyle: FONT_CONST.BOLD_DEFAULT,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: COLOR_CONST.primaryColor,
        indicatorWeight: 2,
      ),
    );
  }

  _buildListOrders(List<OrderModel> orders) {
    return orders.isEmpty
        ? Center(
      child: Image.asset(IMAGE_CONSTANT.NO_RECORD),
    )
        : ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderModelCard(order: orders[index]);
      },
    );
  }
}