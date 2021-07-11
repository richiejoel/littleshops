import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:littleshops/data/model/banner_model.dart';
import 'banner_repository_abstract.dart';

/// Cart is collection in each user
class BannerRepository implements IBannerRepository {

  final refStorage = FirebaseStorage.instance.ref();
  String imagen = "";

  @override
  Future<List<BannerModel>> fetchBanners() async {
    return await FirebaseFirestore.instance
        .collection("banners")
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => BannerModel.fromMap(doc.data()))
            .toList())
        .catchError((err) {});
  }

  Map<String, dynamic> mListStatic(){
    List<BannerModel> models = [];
    BannerModel model = new BannerModel(id: "rerfrg", imageUrl: "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Feletronics_products.png?alt=media&token=0b6c711b-45c0-4ee7-bb75-6b109807e4a4");
    BannerModel mode2 = new BannerModel(id: "trtt", imageUrl: "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Ftools_products.jpeg?alt=media&token=f9927ece-bf19-495f-bf78-9fbb70f56efd");
    BannerModel model3 = new BannerModel(id: "trt", imageUrl: "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Ffast_food.jpeg?alt=media&token=4d0079ea-95b7-4df3-8eaa-8976820c90b0");
    BannerModel model4 = new BannerModel(id: "hyhyy", imageUrl: "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Fbasic_products.jpeg?alt=media&token=2a9a0bfe-27ea-4c52-96fc-aa2608ab8a3b");
    models.add(model);
    models.add(mode2);
    models.add(model3);
    models.add(model4);

    Map<String, dynamic> probe = {};
    probe[model.id] = model.imageUrl;
    probe[mode2.id] = model.imageUrl;
    probe[model3.id] = model.imageUrl;
    probe[model4.id] = model.imageUrl;

    return probe;
  }

  ///Singleton factory
  static final BannerRepository _instance =
  BannerRepository._internal();

  factory BannerRepository() {
    return _instance;
  }

  BannerRepository._internal();
}