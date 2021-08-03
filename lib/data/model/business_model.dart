import 'package:equatable/equatable.dart';

class BusinessModel extends Equatable {
  final String id;
  final String chiefId;
  final String name;
  final String description;
  final dynamic imageUrl;
  final double latitude;
  final double longitude;

  BusinessModel({
    required this.id,
    required this.chiefId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude
  });

  
  static BusinessModel fromMap(String id, Map<String, dynamic> data){
    return BusinessModel(
        id: data["id"] ?? "",
        chiefId: data["chiefId"] ?? "",
        name: data["name"] ?? "",
        description: data["description"] ?? "",
        imageUrl: data["imageUrl"] ?? "",
        latitude: data["latitude"] ?? "",
        longitude: data["longitude"] ?? "",
    );
  }

  BusinessModel cloneWith({
    id,
    chiefId,
    name,
    description,
    imageUrl,
    latitude,
    longitude
  }){
    return BusinessModel(
        id: id ?? this.id,
        chiefId: chiefId ?? this.chiefId,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude
    );
  }

  Map<String, dynamic> toMap(String newID) {
    return {
      "id": newID,
      "chiefId": this.chiefId,
      "name": this.name,
      "description": this.description,
      "imageUrl": this.imageUrl,
      "latitude": this.latitude,
      "longitude": this.longitude
    };
  }
  
  @override
  List<Object?> get props => [id, chiefId, name,
    description, imageUrl, latitude, longitude];

}