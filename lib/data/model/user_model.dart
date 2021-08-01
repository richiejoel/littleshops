import 'package:littleshops/data/model/delivery_address_model.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  /// The current user's id.
  final String id;

  /// The current user's email address.
  final String email;

  /// The current user's name (display name).
  final String name;

  /// Url for the current user's photo.
  final String avatar;

  /// The user's phone number
  final String phoneNumber;

  /// The role's user
  final String role;

  final List<DeliveryAddressModel> addresses;

  /// Get default address
  DeliveryAddressModel? get defaultAddress {
    return addresses.isEmpty
        ? null
        : addresses.firstWhere((address) => address.isDefault);
  }

  /// Constructor
  const UserModel({
    required this.email,
    required this.id,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
    required this.role,
    required this.addresses,
  });

  /// Json data from server turns into model data
  static UserModel fromMap(Map<String, dynamic> data) {
    List<DeliveryAddressModel> addresses = [];
    if (data["addresses"] != null) {
      data["addresses"].forEach((item) {
        addresses.add(DeliveryAddressModel.fromMap(item));
      });
    }
    return UserModel(
      id: data["id"] ?? "",
      name: data["name"] ?? "",
      email: data["email"] ?? "",
      avatar: data["avatar"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      role: data["role"] ?? "",
      addresses: addresses,
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "email": this.email,
      "name": this.name,
      "avatar": this.avatar,
      "phoneNumber": this.phoneNumber,
      "role": this.role,
      "addresses":
          List<dynamic>.from(this.addresses.map((item) => item.toMap()))
    };
  }

  /// Clone and update
  UserModel cloneWith({
    email,
    id,
    addresses,
    phoneNumber,
    name,
    avatar,
    role,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  String toString() {
    return "UserModel:{email:${this.email},name:${this.name},phoneNumber:${this.phoneNumber},avatar:${this.avatar},role:${this.role},addresses:${this.addresses}}";
  }

  /// Compare two users
  @override
  List<Object?> get props => [email, id, name, avatar, phoneNumber, role, addresses];
}
