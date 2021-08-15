import 'package:littleshops/data/model/feedback_model.dart';

abstract class IFeedbackRepository {
  /// Stream of feedback
  /// [pid] is product id
  /// Created by RJG
  Stream<List<FeedBackModel>>? fetchFeedbacks(String pid);

  /// Add new doc to feedbacks collection
  /// [pid] is product id
  /// [newItem] is data of new feedback
  /// Created by RJG
  Future<void> addNewFeedback(String pid, FeedBackModel newItem);

  /// Get feedbacks by star
  /// [pid] is product id
  /// [star] is number of stars
  /// Created by RJG
  Future<List<FeedBackModel>> getFeedbacksByStar(String pid, int star);
}
