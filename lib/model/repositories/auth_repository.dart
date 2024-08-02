import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wave_learning_app/model/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  signUpWithEmailAndPassword(UserModel user, String password) async {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: user.email, password: password);
    return userCredential.user;
  }

  signInWithEmailAndPassword(email, password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    // await verifyUser();
    return userCredential.user;
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    }
  }

  checkLoginStatus() {
    final user = _auth.currentUser;
    return user;
  }

  forgotPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);

    // log(e.toString());
  }

  addUserToDatabase(String name) async {
   
        try {
           final user = UserModel(
        uid: _auth.currentUser!.uid,
        userName: name,
        email: _auth.currentUser!.email.toString());
          await db.collection('users').doc().set(user.toMap());
          log('added');
        } catch (e) {
          log("error$e");
        }
    
  }
}
