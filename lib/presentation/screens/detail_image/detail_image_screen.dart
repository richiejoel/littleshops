import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/presentation/widgets/buttons/default_button.dart';
import 'package:littleshops/utils/translate.dart';
import 'package:uuid/uuid.dart';

class DetailImageScreen extends StatelessWidget {
  final String imageUrl;

  const DetailImageScreen({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  void onSave(BuildContext context) async {
    var response = await Dio().get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: Uuid().v1(),
    );

    print("save success");

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        color: Colors.black,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return DefaultButton(
                  onPressed: () => onSave(context),
                  backgroundColor: Colors.white,
                  child: Text(
                    Translate.of(context).translate("save"),
                    style: FONT_CONST.BOLD_DEFAULT_18,
                  ),
                );
              },
            );
          },
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}