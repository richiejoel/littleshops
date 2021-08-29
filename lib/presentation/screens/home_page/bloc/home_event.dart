import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHome extends HomeEvent {}

class LoadHomeBusiness extends HomeEvent {
  final String businessID;
  LoadHomeBusiness({required this.businessID});
}

class RefreshHome extends HomeEvent {}

class RefreshProductByBusiness extends HomeEvent {
  final String businessID;
  RefreshProductByBusiness({required this.businessID});
}