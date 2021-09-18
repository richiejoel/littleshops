import 'package:flutter/material.dart';

import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';

class SectionWidgetGrid extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Function()? handleOnSeeAll;

  const SectionWidgetGrid({
    required this.title,
    required this.children,
    this.handleOnSeeAll,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.defaultSize * 1.5),
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultPadding),
      color: COLOR_CONST.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Section title
          SectionTitle(
            title: title,
            handleOnSeeAll: handleOnSeeAll,
          ),
          SizedBox(height: SizeConfig.defaultSize),

          /// Section content
          SingleChildScrollView(
            child:
              GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height * 0.7),
                      ),
                  itemCount: children.length,
                  itemBuilder: (BuildContext ctx, index){
                    return children[index];
                  }
              ),
               /*GridView.count(
                 physics: ScrollPhysics(),
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height * 0.7),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: children,
              ),*/
          ),

          /*Container(
            child: children.length == 0
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize * 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              ),
              ),
          ),*/
        ],
      ),
    );
  }
}

/// Section title
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.handleOnSeeAll,
  }) : super(key: key);

  final String title;
  final Function()? handleOnSeeAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: FONT_CONST.SUBTITLE_SCREEN,
          ),
          // See more button
          /*InkWell(
            child: Text(
              Translate.of(context).translate("see_all"),
              style: FONT_CONST.BOLD_PRIMARY_16,
            ),
            onTap: handleOnSeeAll,
          )*/
        ],
      ),
    );
  }
}
