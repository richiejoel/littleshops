import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final String id;
  final String imageUrl;

  BannerModel({required this.id, required this.imageUrl});

  /// Json data from server turns into model data
  static BannerModel fromMap(Map<String, dynamic> data ) {
    //print("Pruebita -> " + (data ?? const{})["imageUrl"] ?? "");

    return BannerModel(
      id: (data ?? const{}) ["id"] ?? "" ,
      imageUrl: (data ?? const{})["imageUrl"] ?? "",
    );
  }

  /// From model data turns into json data => server
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.imageUrl,
    };
  }

  @override
  String toString() {
    return 'BannerModel{id: $id, url: $imageUrl}';
  }

  @override
  List<Object?> get props => [id, imageUrl];
}