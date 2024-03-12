import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './main.dart';
import 'package:culture_pot/models/user.dart' as model;

class userProfile extends StatefulWidget {
  @override
  State<userProfile> createState() => _userProfile();
}

class _userProfile extends State<userProfile> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    if (user == null) {
      // Handle the case where the user is null
      return Scaffold(
        body: Center(
          child: Text('User is null'),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Text(user.username + user.email + user.bio),
      ),
    );
  }
}
