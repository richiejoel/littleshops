import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/business_model.dart';

abstract class BusinessEvent extends Equatable {
  const BusinessEvent();

  @override
  List<Object> get props => [];
}

class LoadBusiness extends BusinessEvent {}

class AddBusiness extends BusinessEvent {
  final BusinessModel newBusinessModel;
  final File image;

  AddBusiness(this.newBusinessModel, this.image);

  List<Object> get props => [newBusinessModel];
}