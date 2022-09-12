import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService extends ChangeNotifier{
  final _firebaseAuth = FirebaseAuth.instance;


  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    }
    else{
      return null;
    }
  }

  Future<User?>SignOut()async{
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();

  }

  Stream<User?>authStatus(){
    return _firebaseAuth.authStateChanges();
  }


}
