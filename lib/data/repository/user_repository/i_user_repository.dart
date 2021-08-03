import 'package:littleshops/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IUserRepository {
  /// Stream of logged user model
  /// [loggedFirebaseUser] is user of firebase auth
  /// Created by NDH
  Stream<UserModel> loggedUserStream(User loggedFirebaseUser);

  /// Get user by id
  /// [uid] is user id
  /// Created by NDH
  Future<UserModel> getUserById(String uid);

  /// Add new doc to users collection
  /// [user] is data of new user
  /// Created by NDH
  Future<void> addUserData(UserModel newUser);

  /// Update a doc in users collection
  /// [user] is updated data of user
  /// Created by NDH
  Future<void> updateUserData(UserModel updatedUser);

  /// Update a doc in users collection
  /// [user] is updated data of user one
  /// Created by RGM
  Future<void> updateOneDataUser(String uid, String key, String value);
}
