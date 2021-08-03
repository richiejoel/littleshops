import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/business_model.dart';

abstract class BusinessState extends Equatable {
  const BusinessState();

  @override
  List<Object> get props => [];

}

/// Loading business
class BusinessLoading extends BusinessState {}

/// Loaded Business
class BusinessLoaded extends BusinessState {
  final List<BusinessModel> allBusiness;
  final List<BusinessModel> businessByChief;

  BusinessLoaded({
    required this.allBusiness,
    required this.businessByChief
  });

  @override
  List<Object> get props => [this.allBusiness, this.businessByChief];
}

/// MyOrders wasn't loaded
class BusinessLoadFailure extends BusinessState {
  final String error;

  BusinessLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}