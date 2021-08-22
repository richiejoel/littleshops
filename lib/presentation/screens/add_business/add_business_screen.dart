import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:littleshops/configs/size_config.dart';
import 'package:littleshops/constants/color_constants.dart';
import 'package:littleshops/constants/font_constant.dart';
import 'package:littleshops/constants/icon_constant.dart';
import 'package:littleshops/constants/image_constants.dart';
import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/navigation_drawer.dart';
import 'package:littleshops/presentation/common_blocs/business/bloc.dart';
import 'package:littleshops/presentation/widgets/buttons/cart_button.dart';
import 'package:littleshops/presentation/widgets/buttons/circle_button.dart';
import 'package:littleshops/presentation/widgets/buttons/circle_icon_button.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/utils/dialog.dart';
import 'package:littleshops/utils/translate.dart';

class AddBusinessScreen extends StatefulWidget{
  @override
  _AddBusinessScreenState createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {

  final TextEditingController nameBusinessController = TextEditingController();
  final TextEditingController descriptionBusinessController = TextEditingController();

  File? imageCurrent;

  BusinessModel newBusiness = BusinessModel(
    id: "",
    chiefId: "",
    description: "",
    name: "",
    imageUrl: "",
    latitude: 0,
    longitude: 0,
    couriers: []
  );

  @override
  void dispose() {
    nameBusinessController.dispose();
    descriptionBusinessController.dispose();
    super.dispose();
  }

  bool isAddBusinessButtonEnabled() {
    return isPopulated;
  }

  bool get isPopulated =>
          nameBusinessController.text.isNotEmpty &&
          descriptionBusinessController.text.isNotEmpty;


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BusinessBloc>(context).add(LoadBusiness());
    return BlocBuilder<BusinessBloc, BusinessState>(
        builder: (context, state){
          if(state is BusinessLoaded){
            return Scaffold(
              drawer: NavigationDrawer(),
              appBar: AppBar(
                title: Text("Little Shops", style: FONT_CONST.TITLE_APPBAR,),
                backgroundColor: COLOR_CONST.primaryColor,
                actions: [
                  CartButton(color: COLOR_CONST.whiteColor),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.message, color: Colors.white,),
                  ),
                ],
              ),
              body: SafeArea(
                child: Container(
                  color: COLOR_CONST.backgroundColor,
                  child: Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultPadding,
                      vertical: SizeConfig.defaultSize * 3,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("Add Business", style: FONT_CONST.SUBTITLE_SCREEN),
                          SizedBox(height: SizeConfig.defaultSize * 2),
                          _buildProductsPictures(context),
                          SizedBox(height: SizeConfig.defaultSize),
                          _buildNameBusiness(context),
                          SizedBox(height: SizeConfig.defaultSize),
                          _buildDescriptionBusiness(context),
                          SizedBox(height: SizeConfig.defaultSize * 1.5),
                          _buildButtonAddBusiness(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          if(state is BusinessLoading){
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


  _buildNameBusiness(BuildContext context) {
    return TextFormField(
      controller: nameBusinessController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('name_product'),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  _buildDescriptionBusiness(BuildContext context) {
    return TextFormField(
      controller: descriptionBusinessController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('description_product'),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  void onUploadPictures(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    File? imageFile;
    final file = await picker.getImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile = File(file.path);
      setState(() {
        imageCurrent = imageFile;
      });
      //BlocProvider.of<ProfileBloc>(context).add(UploadAvatar(imageFile));
    }
  }

  _buildProductsPictures(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            height: SizeConfig.defaultSize * 15,
            width: SizeConfig.defaultSize * 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: CircleAvatar(
              backgroundImage: imageCurrent != null
                  ? FileImage(File(imageCurrent!.path))
                  : AssetImage(IMAGE_CONSTANT.DEFAULT_AVATAR)
              as ImageProvider<Object>,
            )
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleIconButton(
            onPressed: () => onUploadPictures(context),
            svgIcon: ICON_CONST.CAMERA,
            color: COLOR_CONST.cardShadowColor,
            size: SizeConfig.defaultSize * 3,
          ),
        )
      ],
    );
  }

  _buildButtonAddBusiness(BuildContext context) {
    return CircleButton(
      child: Icon(Icons.check, color: Colors.white),
      onPressed: () => onAddBusiness(context),
      backgroundColor: isAddBusinessButtonEnabled()
          ? COLOR_CONST.primaryColor
          : COLOR_CONST.cardShadowColor,
    );
  }

  void onAddBusiness(BuildContext context) async {
    UtilDialog.showWaiting(context);
    await Future.delayed(Duration(seconds: 2));
    if(isAddBusinessButtonEnabled()){
      BusinessModel addBusiness = newBusiness.cloneWith(
        name: nameBusinessController.text,
        description: descriptionBusinessController.text,
      );
      BlocProvider.of<BusinessBloc>(context).add(AddBusiness(addBusiness, imageCurrent!));
      UtilDialog.hideWaiting(context);
      UtilDialog.showInformation(context, content: "Negocio añadido con éxito!!");
    }
  }

}