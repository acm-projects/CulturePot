import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  String? getCurrentUserId() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;
      return userId;
    } else {
      return null;
    }
  }

  // CREATE: add a new post
  Future<void> addPost(String post) {
    return posts.add({
      'post': post,
      'timestamp': Timestamp.now(),
      'uid': getCurrentUserId(),
    });
  }

  // READ: get posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream =
        posts.orderBy('timestamp', descending: true).snapshots();

    return postsStream;
  }

  // UPDATE: update posts from a given doc id
  Future<void> updatePost(String docID, String newPost) {
    return posts.doc(docID).update({
      'post': newPost,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete notes given a doc id
  Future<void> deletePost(String docID) {
    return posts.doc(docID).delete();
  }

  Future<void> addUser(String email, String uid,
      {List<String> friends = const []}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic> userData = {
        "email": email,
        "uid": user.uid,
        "friends": friends,
      };
      await users.doc(user.uid).set(userData);
    } else {
      // Handle the case where the user is not signed in
      // You might throw an exception, return a future with an error, etc.
      throw Exception("User is not signed in");
    }
  }
}