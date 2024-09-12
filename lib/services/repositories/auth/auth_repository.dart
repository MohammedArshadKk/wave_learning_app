import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wave_learning_app/model/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  signUpWithEmailAndPassword(UserModel user, String password) async {
    final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
            email: user.email.toString(), password: password);
    return userCredential.user;
  }

  signInWithEmailAndPassword(email, password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    // await verifyUser();
    return userCredential.user;
  }

  signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);
      return userCredential.user;
    } else {
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
        log(userCredential.user!.email.toString());
        log(userCredential.user!.displayName.toString());
        return userCredential.user;
      }
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

  saveGoogleUserToDatabase() async {
    final isNotExists =
        await checkEmailElreadyExists(_auth.currentUser!.email.toString());
    try {
      if (isNotExists) {
        final user = UserModel(
            uid: _auth.currentUser!.uid,
            userName: _auth.currentUser!.displayName.toString(),
            email: _auth.currentUser!.email.toString());
        await db.collection('users').doc().set(user.toMap());
        log('added');
      } else {}
    } catch (e) {
      log("error$e");
    }
  }

  Future<bool> checkEmailElreadyExists(String email) async {
    final QuerySnapshot data =
        await db.collection('users').where('email', isEqualTo: email).get();
    final document = data.docs;
    return document.isEmpty;
  }
}
