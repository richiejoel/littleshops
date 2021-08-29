import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/product_model.dart';

import 'package:littleshops/presentation/screens/home_page/bloc/home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Loading
class HomeLoading extends HomeState {}

/// Adready data
class HomeLoaded extends HomeState {
  final HomeResponse homeResponse;

  const HomeLoaded({required this.homeResponse});

  @override
  List<Object?> get props => [homeResponse];
}

/// alredy data business
class HomeLoadedBusiness extends HomeState {
  final List<Product> productsByBusiness;

  const HomeLoadedBusiness({required this.productsByBusiness});

  @override
  List<Object?> get props => [productsByBusiness];
}

/// Failure
class HomeLoadFailure extends HomeState {
  final String error;

  const HomeLoadFailure(this.error);
}

