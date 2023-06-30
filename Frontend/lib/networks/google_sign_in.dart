import 'package:bus_book/models/google_sign_in_credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bus_book/models/google_sign_in_credentials.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> signInWithGoogle(BuildContext context) async {

  User? user;

  // The `GoogleAuthProvider` can only be used while running on the web
  GoogleAuthProvider authProvider = GoogleAuthProvider();

  try {
    final UserCredential userCredential =
        await _auth.signInWithPopup(authProvider);

    user = userCredential.user;
  } catch (e) {
    print(e);
  }

  if (user != null) {
    google_sign_in_credentials.google_Email = user.email ?? "";
    //print(google_sign_in_credentials.google_Email);
  }
  //print(user);
  return user;
}