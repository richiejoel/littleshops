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
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/presentation/screens/add_products/bloc/add_products_bloc.dart';
import 'package:littleshops/presentation/widgets/buttons/cart_button.dart';
import 'package:littleshops/presentation/widgets/buttons/circle_button.dart';
import 'package:littleshops/presentation/widgets/buttons/circle_icon_button.dart';
import 'package:littleshops/presentation/widgets/others/loading.dart';
import 'package:littleshops/utils/dialog.dart';
import 'package:littleshops/utils/translate.dart';

import '../../../navigation_drawer.dart';
import 'bloc/add_products_event.dart';
import 'bloc/add_products_state.dart';

class AddProductsScreen extends StatefulWidget{
  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen>{

  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController descriptionProductController = TextEditingController();
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController percentOffController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  CategoryModel? selectedCategory;
  BusinessModel? selectedBusiness;
  List<File> imagesLocal = [];
  File? imageCurrent, imageCurrentTwo, imageCurrentThree, imageCurrentFour;
  Product? newProduct = Product(
      id: "", images: [""],
      rating: 2, isAvailable: true,
      quantity: 3, categoryId: "categoryId",
      name: "name", originalPrice: 30,
      percentOff: 2, soldQuantity: 0,
      description: "description", businessId: "",

  );
  UtilDialog? dialog;

  void onCategoryChanged(BuildContext context, CategoryModel category ){
    setState(() {
      selectedCategory =  category;
    });
  }

  void onBusinessChanged(BuildContext context, BusinessModel business ){
    setState(() {
      selectedBusiness =  business;
    });
  }

  @override
  void dispose() {
    nameProductController.dispose();
    descriptionProductController.dispose();
    originalPriceController.dispose();
    percentOffController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  bool isAddProductButtonEnabled() {
    return isPopulated;
  }

  bool get isPopulated =>
      nameProductController.text.isNotEmpty &&
          descriptionProductController.text.isNotEmpty &&
          originalPriceController.text.isNotEmpty &&
          percentOffController.text.isNotEmpty &&
          quantityController.text.isNotEmpty &&
          selectedCategory!.id.isNotEmpty;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddProductBloc()..add(LoadAddProduct()),
      child: Builder(
        builder: (context){
          return BlocListener<AddProductBloc, AddProductState>(
            listener: (context, state){
              /*if (die) {
                UtilDialog.showWaiting(context);
              }
              if (!die && hide) {
                UtilDialog.hideWaiting(context);
              }
              if (!die && hasError) {
                UtilDialog.showWaiting(context);
                UtilDialog.showInformation(context, content: "Error in backend");
              }*/
            },
            child: BlocBuilder<AddProductBloc, AddProductState>(
              builder: (context, state) {
                if(state is AddProductLoaded){
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
                                  Text("Add products", style: FONT_CONST.SUBTITLE_SCREEN),
                                  SizedBox(height: SizeConfig.defaultSize * 2),
                                  _buildNameProduct(context),
                                  SizedBox(height: SizeConfig.defaultSize),
                                  _buildDescriptionProduct(context),
                                  SizedBox(height: SizeConfig.defaultSize),
                                  _buildOriginalPrice(context),
                                  SizedBox(height: SizeConfig.defaultSize),
                                  _buildPercentOff(context),
                                  SizedBox(height: SizeConfig.defaultSize),
                                  _buildQuantityProduct(context),
                                  SizedBox(height: SizeConfig.defaultSize),
                                  _buildCategoriesPicker(context, state.categories),
                                  SizedBox(height: SizeConfig.defaultSize),
                                  _buildBusinessPicker(context, state.business),
                                  SizedBox(height: SizeConfig.defaultSize),
                                  mProductsAdded(context),
                                  SizedBox(height: SizeConfig.defaultSize),
                                  _buildButtonAddProduct(context),
                                ],
                              ),
                            ),
                          ),
                        ),

                    )
                  );
                }
                if(state is AddProductLoading){
                  return Scaffold(
                    body: Container(
                      color: COLOR_CONST.backgroundColor,
                      child: Loading(),
                    ),
                  );
                }
                return Center(child: Text("Something went wrong."));
              },
            ),
          );
        },
      ),
    );

  }

  Widget mProductsAdded(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        height: 145,
        child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildProductsPictures(context, 0),
          SizedBox(width: SizeConfig.defaultSize),
          _buildProductsPicturesTwo(context, 1),
          SizedBox(width: SizeConfig.defaultSize),
          _buildProductsPicturesThree(context, 2),
          SizedBox(width: SizeConfig.defaultSize),
          _buildProductsPicturesFour(context, 3),
        ],
      ),
      ),
    );
  }

  _buildNameProduct(BuildContext context) {
    return TextFormField(
      controller: nameProductController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('name_product'),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  _buildDescriptionProduct(BuildContext context) {
    return TextFormField(
      controller: descriptionProductController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('description_product'),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  _buildOriginalPrice(BuildContext context) {
    return TextFormField(
      controller: originalPriceController,
      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('original_price'),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  _buildPercentOff(BuildContext context) {
    return TextFormField(
      controller: percentOffController,
      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('percent_off'),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  _buildQuantityProduct(BuildContext context) {
    return TextFormField(
      controller: quantityController,
      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
      decoration: InputDecoration(
        hintText: Translate.of(context).translate('quantity_product'),
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  _buildCategoriesPicker(BuildContext context, List<CategoryModel> categories) {
    return DropdownButtonFormField<CategoryModel>(
      decoration: InputDecoration(
        labelText: Translate.of(context).translate("product_categories"),
      ),
      onChanged: (category) => onCategoryChanged(context, category!),
      items: getDropdownItems(categories),
      value: categories.isEmpty ? null : selectedCategory,
    );
  }

  _buildBusinessPicker(BuildContext context, List<BusinessModel> business) {
    return DropdownButtonFormField<BusinessModel>(
      decoration: InputDecoration(
        labelText: Translate.of(context).translate("product_categories"),
      ),
      onChanged: (business) => onBusinessChanged(context, business!),
      items: getDropdownItemsBusiness(business),
      value: business.isEmpty ? null : selectedBusiness,
    );
  }

  _buildButtonAddProduct(BuildContext context) {
    return CircleButton(
      child: Icon(Icons.check, color: Colors.white),
      onPressed: () => onAddProduct(context),
      backgroundColor: isAddProductButtonEnabled()
          ? COLOR_CONST.primaryColor
          : COLOR_CONST.cardShadowColor,
    );
  }

  void onAddProduct(BuildContext context) async  {
    UtilDialog.showWaiting(context);
    await Future.delayed(Duration(seconds: 2));
    if(isAddProductButtonEnabled()){
      Product? addProduct = newProduct!.cloneWith(
        name: nameProductController.text,
        description: descriptionProductController.text,
        originalPrice: double.parse(originalPriceController.text),
        percentOff: double.parse(percentOffController.text),
        quantity: int.parse(quantityController.text),
        categoryId: selectedCategory!.id,
        rating: 0,
        soldQuantity: 0,
        isAvailable: true,
        businessId: selectedBusiness!.id
      );
      BlocProvider.of<AddProductBloc>(context).add(AddNewProduct(imagesLocal, addProduct!));
      UtilDialog.hideWaiting(context);
      UtilDialog.showInformation(context, content: "Producto añadido con éxito");
    }
  }

  getDropdownItems(List<CategoryModel> list) {
    return list
        .map((item) => DropdownMenuItem(child: Text(item.name), value: item))
        .toList();
  }

  getDropdownItemsBusiness(List<BusinessModel> list) {
    return list
        .map((item) => DropdownMenuItem(child: Text(item.name), value: item))
        .toList();
  }

  void onUploadPictures(BuildContext context, int index) async {
    ImagePicker picker = ImagePicker();
    File? imageFile;
    final file = await picker.getImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile = File(file.path);
      imagesLocal.add(imageFile);
      setState(() {
        if(index == 0){
          imageCurrent = imageFile;
        } else if( index == 1){
          imageCurrentTwo = imageFile;
        } else if( index == 2){
          imageCurrentThree = imageFile;
        } else if( index == 3){
          imageCurrentFour = imageFile;
        }
        //imagesLocal![index] = imageFile!;

        //imagesLocal = [...imagesLocal!];//
        //imagesLocal!.insert(index, imageFile!);
        //imagesLocal = List.from(imagesLocal!)..add(imageFile!);

      });
      //BlocProvider.of<ProfileBloc>(context).add(UploadAvatar(imageFile));
    }
  }

  _buildProductsPictures(BuildContext context, int index ) {
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
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageCurrent != null
                    ? FileImage(File(imageCurrent!.path))
                    : AssetImage(IMAGE_CONSTANT.DEFAULT_AVATAR)
                as ImageProvider<Object>,
              )
            ),
          )
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleIconButton(
            onPressed: () => onUploadPictures(context, index),
            svgIcon: ICON_CONST.CAMERA,
            color: COLOR_CONST.cardShadowColor,
            size: SizeConfig.defaultSize * 3,
          ),
        )
      ],
    );
  }

  _buildProductsPicturesTwo(BuildContext context, int index ) {
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
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageCurrentTwo != null
                        ? FileImage(File(imageCurrentTwo!.path))
                        : AssetImage(IMAGE_CONSTANT.DEFAULT_AVATAR)
                    as ImageProvider<Object>,
                  )
              ),
            )
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleIconButton(
            onPressed: () => onUploadPictures(context, index),
            svgIcon: ICON_CONST.CAMERA,
            color: COLOR_CONST.cardShadowColor,
            size: SizeConfig.defaultSize * 3,
          ),
        )
      ],
    );
  }

  _buildProductsPicturesThree(BuildContext context, int index ) {
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
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageCurrentThree != null
                        ? FileImage(File(imageCurrentThree!.path))
                        : AssetImage(IMAGE_CONSTANT.DEFAULT_AVATAR)
                    as ImageProvider<Object>,
                  )
              ),
            )
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleIconButton(
            onPressed: () => onUploadPictures(context, index),
            svgIcon: ICON_CONST.CAMERA,
            color: COLOR_CONST.cardShadowColor,
            size: SizeConfig.defaultSize * 3,
          ),
        )
      ],
    );
  }

  _buildProductsPicturesFour(BuildContext context, int index ) {
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
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageCurrentFour != null
                        ? FileImage(File(imageCurrentFour!.path))
                        : AssetImage(IMAGE_CONSTANT.DEFAULT_AVATAR)
                    as ImageProvider<Object>,
                  )
              ),
            )
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleIconButton(
            onPressed: () => onUploadPictures(context, index),
            svgIcon: ICON_CONST.CAMERA,
            color: COLOR_CONST.cardShadowColor,
            size: SizeConfig.defaultSize * 3,
          ),
        )
      ],
    );
  }

}