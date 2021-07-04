import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:littleshops/data/model/banner_model.dart';
import 'banner_repository_abstract.dart';

/// Cart is collection in each user
class BannerRepository implements IBannerRepository {
  @override
  Future<List<BannerModel>> fetchBanners() async {
    return await FirebaseFirestore.instance
        .collection("banners")
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => BannerModel.fromMap(doc.data()!))
        .toList())
        .catchError((err) {});
  }

  ///Singleton factory
  static final BannerRepository _instance =
  BannerRepository._internal();

  factory BannerRepository() {
    return _instance;
  }

  BannerRepository._internal();
}