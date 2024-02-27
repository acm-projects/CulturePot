import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of posts
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");

  // CREATE: add a new post
  Future<void> addPost(String post) {
    return posts.add({
      'post': post,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get posts from database

  // UPDATE: update posts given a doc id

  // DELETE: delete posts given a doc id
}
