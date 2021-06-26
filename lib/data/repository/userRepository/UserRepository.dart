import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:littleshops/data/model/UserModel.dart';
import 'package:littleshops/data/repository/userRepository/IUserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository implements IUserRepository {
  var _userCollection = FirebaseFirestore.instance.collection("users");

  /// Stream of logged user model
  /// [loggedFirebaseUser] is user of firebase auth
  /// Created by NDH
  Stream<UserModel> loggedUserStream(User loggedFirebaseUser) {
    return _userCollection
        .doc(loggedFirebaseUser.uid)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data()!));
  }

  /// Get user by id
  /// [uid] is user id
  /// Created by NDH
  Future<UserModel> getUserById(String uid) async {
    return await _userCollection
        .doc(uid)
        .get()
        .then((doc) => UserModel.fromMap(doc.data()!))
        .catchError((error) {});
  }

  /// Add new doc to users collection
  /// [user] is data of new user
  /// Created by NDH
  Future<void> addUserData(UserModel newUser) async {
    await _userCollection
        .doc(newUser.id)
        .set(newUser.toMap())
        .catchError((error) => print(error));
  }

  /// Update a doc in users collection
  /// [user] is updated data of user
  /// Created by NDH
  Future<void> updateUserData(UserModel updatedUser) async {
    await _userCollection.doc(updatedUser.id).get().then((doc) async {
      if (doc.exists) {
        // update
        await doc.reference.update(updatedUser.toMap());
      }
    }).catchError((error) {});
  }

  ///Singleton factory
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();
}
