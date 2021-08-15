import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/data/model/feedback_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/data/repository/auth/auth_repository.dart';
import 'package:littleshops/data/repository/feedback_repository/feedback_repository.dart';
import 'package:littleshops/data/repository/product_repository/product_repository.dart';
import 'package:uuid/uuid.dart';

import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbacksEvent, FeedbackState> {
  final AuthRepository _authRepository = AuthRepository();
  final FeedbackRepository _feedbackRepository =
      FeedbackRepository();
  final ProductRepository _productRepository = ProductRepository();

  late Product _currentProduct;
  double _currAverageRating = 0.0;
  StreamSubscription? _feedbackSubscription;

  FeedbackBloc() : super(FeedbacksLoading());

  @override
  Stream<FeedbackState> mapEventToState(FeedbacksEvent event) async* {
    if (event is LoadFeedbacks) {
      yield* _mapLoadFeedbacksToState(event);
    } else if (event is AddFeedback) {
      yield* _mapAddFeedbackToState(event);
    } else if (event is StarChanged) {
      yield* _mapStarChangedToState(event);
    } else if (event is FeedbacksUpdated) {
      yield* _mapFeedbacksUpdatedToState(event);
    }
  }

  Stream<FeedbackState> _mapLoadFeedbacksToState(LoadFeedbacks event) async* {
    try {
      _currentProduct = event.product;
      _feedbackSubscription?.cancel();
      _feedbackSubscription = _feedbackRepository
          .fetchFeedbacks(_currentProduct.id)!
          .listen((feedback) => add(FeedbacksUpdated(feedback)));
    } catch (e) {
      yield FeedbacksLoadFailure(e.toString());
    }
  }

  Stream<FeedbackState> _mapAddFeedbackToState(AddFeedback event) async* {
    try {
      var newFeedback = FeedBackModel(
        id: Uuid().v1(),
        content: event.content,
        rating: event.rating,
        userId: _authRepository.loggedFirebaseUser.uid,
        timestamp: Timestamp.now(),
      );
      await _feedbackRepository.addNewFeedback(
        _currentProduct.id,
        newFeedback,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<FeedbackState> _mapStarChangedToState(StarChanged event) async* {
    try {
      yield FeedbacksLoading();
      var feedbacks = await _feedbackRepository.getFeedbacksByStar(
        _currentProduct.id,
        event.star,
      );
      yield FeedbacksLoaded(
        feedbacks,
        _currAverageRating,
        feedbacks.length,
      );
    } catch (e) {
      print(e);
    }
  }

  Stream<FeedbackState> _mapFeedbacksUpdatedToState(
      FeedbacksUpdated event,
      ) async* {
    yield FeedbacksLoading();
    // Calculate again average product rating
    double totalRating = 0;
    var feedbacks = event.feedbacks;
    feedbacks.forEach((f) => totalRating += f.rating);
    double averageRating =
    feedbacks.length > 0 ? totalRating / feedbacks.length : 0.0;
    _currAverageRating = double.parse(averageRating.toStringAsFixed(1));
    // Update product rating
    await _productRepository.updateProductRatingById(
      _currentProduct.id,
      _currAverageRating,
    );
    yield FeedbacksLoaded(
      feedbacks,
      _currAverageRating,
      feedbacks.length,
    );
  }

  @override
  Future<void> close() {
    _feedbackSubscription?.cancel();
    return super.close();
  }
}