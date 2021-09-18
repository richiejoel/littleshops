import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/data/repository/auth/auth_repository.dart';
import 'package:littleshops/data/repository/business_repository/business_repository.dart';
import 'package:littleshops/data/repository/product_repository/product_repository.dart';
import 'package:littleshops/data/repository/storage_repository/storage_repository.dart';
import 'package:littleshops/data/repository/user_repository/user_repository.dart';
import 'package:littleshops/presentation/screens/add_products/bloc/add_products_event.dart';
import 'package:littleshops/presentation/screens/add_products/bloc/add_products_state.dart';
import 'package:uuid/uuid.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState>{

  final ProductRepository _productRepository = ProductRepository();
  AuthRepository _authRepository = AuthRepository();
  StorageRepository _storageRepository = StorageRepository();
  UserRepository _userRepository = UserRepository();
  BusinessRepository _businessRepository = BusinessRepository();
  Product? productCurrent = Product(
      id: "", images: [],
      rating: 3, isAvailable: true,
      quantity: 3, categoryId: "categoryId",
      name: "name", originalPrice: 40,
      percentOff: 3, soldQuantity: 3,
      description: "description",
      businessId: "",
  );

  AddProductBloc() : super(AddProductLoading());

  @override
  Stream<AddProductState> mapEventToState(AddProductEvent event) async* {
    if(event is LoadAddProduct) {
      yield* _mapLoadProfileToState(event);
    } else if ( event is AddNewProduct) {
      yield* _mapAddNewProductToState(event);
    }
  }

  /// Load Profile event => states
  Stream<AddProductState> _mapLoadProfileToState(AddProductEvent event) async* {
    try {
      List<CategoryModel> categories = await _productRepository.getCategories();
      List<BusinessModel> business = await _businessRepository
          .fetchBusinessByChief(_authRepository.loggedFirebaseUser.uid);
      UserModel userLogged = await _userRepository
          .getUserById(_authRepository.loggedFirebaseUser.uid);
      yield AddProductLoaded(userLogged, categories, business);

    } catch (e) {
      yield AddProductLoadFailure(e.toString());
    }
  }

  /// Upload Avatar event => states
  Stream<AddProductState> _mapAddNewProductToState(AddNewProduct event) async* {
    try {
      // Get image url from firebase storage
      List<File> images = [];
      List<dynamic> imagesUrl = [];
      String imageUrl = "";

      for(int i=0; i<event.imageFiles.length; i++){
        images.insert(i, event.imageFiles.elementAt(i));
      }

      Product? newProduct = event.product;
      for(int i=0; i<images.length; i++) {
        imageUrl = await _storageRepository.uploadImageFile(
          "products/${Uuid().v1()}",
          images.elementAt(i),
        );
        imagesUrl.add(imageUrl);
      }

      var addProduct = productCurrent!.cloneWith(
          name: newProduct!.name,
          description: newProduct!.description,
          originalPrice: newProduct!.originalPrice,
          percentOff: newProduct!.percentOff,
          categoryId: newProduct!.categoryId,
          quantity: newProduct!.quantity,
          isAvailable: newProduct!.isAvailable,
          rating: newProduct!.rating,
          soldQuantity: newProduct!.soldQuantity,
          images: imagesUrl,
          businessId: newProduct!.businessId
      );

      print(imagesUrl);

      await _productRepository.addProductByChief(addProduct);

    } catch (e) {

    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
  

}