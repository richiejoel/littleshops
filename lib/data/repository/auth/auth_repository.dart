import 'package:littleshops/data/model/business_model.dart';
import 'package:littleshops/data/model/user_model.dart';
import 'package:littleshops/data/repository/auth/i_auth_repository.dart';
import 'package:littleshops/data/repository/business_repository/business_repository.dart';
import 'package:littleshops/data/repository/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository implements IAuthRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // GoogleSignIn _googleSignIn = GoogleSignIn();
  UserRepository _userRepository = UserRepository();
  String _authException = "Authentication Failure";
  User get loggedFirebaseUser => _firebaseAuth.currentUser!;
  String get authException => _authException;
  BusinessRepository _businessRepository = BusinessRepository();

  /// Don't use onAuthChange
  /// Creates a new user with the provided [information]
  /// Created by NDH
  Future<void> signUp(UserModel newUser, String password, {String? businessId}) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: newUser.email,
        password: password,
      );
      // Add id for new user
      newUser = newUser.cloneWith(id: userCredential.user!.uid);

      if(businessId != null){
        _businessRepository.updateCouriersBusiness(businessId, newUser.id);
      }

      // Create new doc in users collection
      await _userRepository.addUserData(newUser);
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  /// Signs in with the provided [email] and [password].
  /// Created by NDH
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  bool isLoggedIn() => _firebaseAuth.currentUser != null;

  /// Signs out the current user
  /// Created by NDH
  Future<void> logOut() async {
    await _firebaseAuth.signOut().catchError((error) {
      print(error);
    });
  }

  ///Singleton factory
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();
}
