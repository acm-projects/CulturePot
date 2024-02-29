import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("notes");

  // CREATE: add a new post
  Future<void> addPost(String post) {
    return posts.add({
      'post': post,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get posts from database

  // UPDATE: update posts from a given doc id
}
