import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/data/model/user_model.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  List<Object> get props => [];

}

class LoadAddProduct extends AddProductEvent {}

class AddNewProduct extends AddProductEvent {
  final List<File> imageFiles;
  final Product product;

  AddNewProduct(this.imageFiles, this.product);

  List<Object> get props => [imageFiles, product];

}

class AddProductLoadedInit extends AddProductEvent {
  final UserModel updatedUser;
  final List<CategoryModel> categories;

  AddProductLoadedInit(this.updatedUser, this.categories);

  List<Object> get props => [updatedUser, categories];
}