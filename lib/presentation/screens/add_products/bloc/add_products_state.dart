import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/user_model.dart';

abstract class AddProductState extends Equatable {
  @override
  List<Object> get props => [ ];


}

class AddProductLoading extends AddProductState {

}


class AddProductLoaded extends AddProductState {
  final UserModel loggedUser;
  final List<CategoryModel> categories;


  AddProductLoaded(this.loggedUser, this.categories);

  List<Object> get props => [loggedUser, categories];

  @override
  String toString() {
    return "{AddProductLoaded: loggedUser:${this.loggedUser.toString()}}";
  }

}

class AddProductLoadFailure extends AddProductState {
  final String error;

  AddProductLoadFailure(this.error);

  List<Object> get props => [error];
}


