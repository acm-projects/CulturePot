import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of notes
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
}
