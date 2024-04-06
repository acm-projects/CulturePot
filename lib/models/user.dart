import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl; // photourl for profile image
  final String username;
  final String bio;
  final List friends;
  final List preferences;
  final List bookmarks;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.friends,
    required this.preferences,
    required this.bookmarks,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "friends": friends,
        "preferences": preferences,
        "bookmarks": bookmarks,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      friends: snapshot['friends'],
      preferences: snapshot['preferences'],
      bookmarks: snapshot['bookmarks'],
    );
  }
}
