import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:littleshops/data/model/delivery_address_model.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/presentation/common_blocs/profile/profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Load profile of logged firebase user in firestore
class LoadProfile extends ProfileEvent {}

/// Upload user avatar
class UploadAvatar extends ProfileEvent {
  final File imageFile;

  UploadAvatar(this.imageFile);

  List<Object> get props => [imageFile];
}

/// Delivery addresses changed
class AddressListChanged extends ProfileEvent {
  final DeliveryAddressModel deliveryAddress;
  final ListMethod method;

  AddressListChanged({required this.deliveryAddress, required this.method});

  List<Object> get props => [deliveryAddress, method];
}

/// Profile was updated
class ProfileUpdated extends ProfileEvent {
  final UserModel updatedUser;

  ProfileUpdated(this.updatedUser);

  List<Object> get props => [updatedUser];
}

// Evento cambio de name
class NameChanged extends ProfileEvent {
  final String name;

  NameChanged({required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'NameChanged{name: $name}';
  }
}

// Evento cambio de email
class EmailChanged extends ProfileEvent {
  final String email;

  EmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'EmailChanged{email: $email}';
  }
}

// Evento cambio de numero telefono
class PhoneNumberChanged extends ProfileEvent {
  final String phoneNumber;

  PhoneNumberChanged({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];

  @override
  String toString() {
    return 'PhoneNumberChanged{phoneNumber: $phoneNumber}';
  }
}