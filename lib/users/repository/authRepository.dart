import 'package:firebase_auth/firebase_auth.dart';

import 'authFirebaseAPI.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInFirebase(String email, String password) =>
      _firebaseAuthAPI.emailAndPasswordSignIn(email, password);
  Future<FirebaseUser> signInGoogle() => _firebaseAuthAPI.signIn();
  Future<FirebaseUser> signInApple() => _firebaseAuthAPI.handleAppleSignIn();
  Future<FirebaseUser> createAccount(String email, String password) =>
      _firebaseAuthAPI.createAccountEmailAndPassword(email, password);
  void signOut() => _firebaseAuthAPI.signOut();
}
