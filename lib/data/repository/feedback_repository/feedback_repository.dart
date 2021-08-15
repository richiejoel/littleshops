import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:littleshops/data/model/feedback_model.dart';

import 'feedback_repository_abstract.dart';

class FeedbackRepository implements IFeedbackRepository {
  var productCollection = FirebaseFirestore.instance.collection("products");

  /// Stream of feedback
  /// [pid] is product id
  /// Created by NDH
  @override
  Stream<List<FeedBackModel>>? fetchFeedbacks(String pid) {
    try {
      return productCollection
          .doc(pid)
          .collection("feedbacks")
          .orderBy("timestamp", descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => FeedBackModel.fromMap(doc.data()!))
          .toList());
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// Add new doc to feedbacks collection
  /// [pid] is product id
  /// [newItem] is data of new feedback
  /// Created by RJG
  @override
  Future<List<FeedBackModel>> getFeedbacksByStar(String pid, int star) async {
    return star != 0
        ? await productCollection
        .doc(pid)
        .collection("feedbacks")
        .where("rating", isEqualTo: star)
        .orderBy("timestamp", descending: true)
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => FeedBackModel.fromMap(doc.data()!))
        .toList())
        .catchError((error) {})
        : await productCollection
        .doc(pid)
        .collection("feedbacks")
        .orderBy("timestamp", descending: true)
        .get()
        .then((snapshot) => snapshot.docs
        .map((doc) => FeedBackModel.fromMap(doc.data()!))
        .toList())
        .catchError((error) {});
  }

  /// Get feedbacks by star
  /// [pid] is product id
  /// [star] is number of stars
  /// Created by RJG
  @override
  Future<void> addNewFeedback(String pid, FeedBackModel newItem) async {
    var productRef = productCollection.doc(pid);
    await productRef
        .collection("feedbacks")
        .doc(newItem.id)
        .set(newItem.toMap())
        .catchError((error) => print(error));
  }

  ///Singleton factory
  static final FeedbackRepository _instance =
  FeedbackRepository._internal();

  factory FeedbackRepository() {
    return _instance;
  }

  FeedbackRepository._internal();
}