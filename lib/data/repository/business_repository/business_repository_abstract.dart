import 'package:littleshops/data/model/business_model.dart';

abstract class IBusinessRepository {

  /// Get all business of chief
  Future<List<BusinessModel>> fetchAllBusiness();

  /// Get business by Chief
  Future<List<BusinessModel>> fetchBusinessByChief(String chiefId);

  /// Add new business by a chief
  Future<void> addBusinessByChief(BusinessModel newBusinessModel);

}