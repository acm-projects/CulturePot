class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List friends;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.friends,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photourl": photoUrl,
        "bio": bio,
        "friends": friends,
      };
}
