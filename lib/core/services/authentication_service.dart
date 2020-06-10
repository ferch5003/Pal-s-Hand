import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'database_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseAuth get user {
    return _firebaseAuth;
  }

  Future loginWithGoogle({
    @required String email,
    @required String password,
  }) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid);

      await DatabaseService(uid: user.uid).updateUserData(
          name: currentUser.displayName,
          email: currentUser.email,
          image: currentUser.photoUrl);

      return currentUser != null;
    } catch (e) {
      return e.message;
    }
  }

  Future logoutWithGoogle() async {
    try {
      await googleSignIn.signOut();
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signupWithEmail({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    try {
      
      FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      await DatabaseService(uid: user.uid)
          .updateUserData(name: name, email: email, image: '');

      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future logout() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
