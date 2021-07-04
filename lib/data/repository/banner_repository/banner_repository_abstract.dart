import 'package:littleshops/data/model/banner_model.dart';

abstract class IBannerRepository {
// Get all images carousel
  Future<List<BannerModel>> fetchBanners();
}