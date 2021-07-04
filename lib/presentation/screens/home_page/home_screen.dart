import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/presentation/screens/home_page/widgets/home_body.dart';

import 'package:littleshops/presentation/screens/home_page/bloc/home_bloc.dart';
import 'package:littleshops/presentation/screens/home_page/bloc/home_event.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHome()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<HomeBloc>(context).add(RefreshHome());
                },
                child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: [
                    HomeBody(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}