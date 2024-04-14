import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import './storage_methods.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // method to edit user cultural preferences
  Future<String> editUser({
    required String uid,
    required List preferences,
  }) async {
    String res = "Some error occured";
    try {
      // actual logic to implement the stuff
      // takes in a list of cultural preferences, sets the users preferences to that list
      await users.doc(uid).update({
        'preferences': preferences,
      });
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // sign up user
  Future<String> signUpUser({
     required String username,
    required String bio,
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty
         ) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // String photoUrl = await StorageMethods()
        //     .uploadImageToStorage('profilePics', file, false);

        // add user to our database

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
         photoUrl: "dummy_url",
          friends: [],
          preferences: [],
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "user not found";
      }
    }
    (err) {
      res = err.toString();
    };
    return res;
  }

  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
