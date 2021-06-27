import 'package:littleshops/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  User get loggedFirebaseUser;
  String get authException;

  // Create a new user with the
  Future<void> signUp(UserModel newUser, String password);

  /// Signs in with the provided [email] and [password].
  Future<void> logInWithEmailAndPassword(String email, String password);

  /// Starts the Sign In with Google Flow.
  /// Created by NDH
  // Future<void> logInWithGoogle();

  bool isLoggedIn();

  /// Signs out the current user
  /// Created by NDH
  Future<void> logOut();
}
