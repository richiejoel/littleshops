import 'package:flutter/material.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/image_constants.dart';
import 'package:littleshops/data/model/feedback_model.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/data/repository/user_repository/user_repository.dart';
import 'package:littleshops/presentation/widgets/others/custom_card_widget.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/presentation/widgets/others/rating_bar.dart';
import 'package:littleshops/utils/fomatter.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key? key,
    required this.feedBack,
  }) : super(key: key);

  final FeedBackModel feedBack;
  //final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10,
        children: [
          _buildUserInfo(context),
          _buildFeedbackContent(),
          _buildCreatedDate()
        ],
      ),
    );
  }

  _buildUserInfo(BuildContext context) {
    UserRepository userRepository = UserRepository();
    return FutureBuilder(
      future: userRepository.getUserById(feedBack.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var user = snapshot.data as UserModel;
          return Row(
            children: [
              CircleAvatar(
                backgroundImage: (user.avatar.isNotEmpty
                    ? NetworkImage(user.avatar)
                    : AssetImage(IMAGE_CONSTANT.DEFAULT_AVATAR))
                as ImageProvider<Object>?,
              ),
              SizedBox(width: 5),
              // User email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.email, style: FONT_CONST.REGULAR_DEFAULT_20),
                  SizedBox(height: 5),
                  RatingBar(
                    readOnly: true,
                    initialRating: feedBack.rating.toDouble(),
                    itemSize: SizeConfig.defaultSize * 2.4,
                  ),
                ],
              ),
            ],
          );
        }
        return Center(child: Loading());
      },
    );
  }

  _buildFeedbackContent() {
    return Text(
      "${feedBack.content}",
      style: FONT_CONST.BOLD_DEFAULT_20,
    );
  }

  _buildCreatedDate() {
    return Text(
      "${UtilFormatter.formatTimeStamp(feedBack.timestamp)}",
      style: FONT_CONST.REGULAR_DEFAULT_16,
    );
  }
}