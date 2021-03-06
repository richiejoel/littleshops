import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/data/repository/business_repository/business_repository_abstract.dart';

class BusinessRepository implements IBusinessRepository{
  var businessCollection = FirebaseFirestore.instance.collection("business");

  @override
  Future<void> addBusinessByChief(BusinessModel newBusinessModel) async {
    var business = businessCollection.doc();
    await business
        .set(newBusinessModel.toMap(business.id))
        .catchError((error) => print(error));
  }

  @override
  Future<List<BusinessModel>> fetchAllBusiness() async {
    return await businessCollection
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => BusinessModel.fromMap(doc.id, doc.data()!))
        .toList())
        .catchError((error) {});
  }

  @override
  Future<List<BusinessModel>> fetchBusinessByChief(String chiefId) async {
    return await businessCollection
        .where("chiefId", isEqualTo: chiefId)
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => BusinessModel.fromMap(doc.id, doc.data()!))
        .toList())
        .catchError((error) {});
  }


  Future<BusinessModel> fetchCouriersByBusinessID(String businessId) async {
    return await businessCollection
        .doc(businessId)
        .get()
        .then((doc) => BusinessModel.fromMap(doc.id, doc.data()!))
        .catchError((error) {});
  }

  Future<void> updateCouriersBusiness(String uid, String courier) async {
    await businessCollection.doc(uid).get().then((doc) async {
      if (doc.exists) {
        // update
        await doc.reference.update({"couriers": FieldValue.arrayUnion([courier])});
      }
    }).catchError((error) {});
  }

  ///Singleton factory
  static final BusinessRepository _instance =
  BusinessRepository._internal();

  factory BusinessRepository() {
    return _instance;
  }

  BusinessRepository._internal();


}