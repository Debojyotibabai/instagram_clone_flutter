class PostModel {
  const PostModel({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  final String description;
  final String uid;
  final String username;
  final List likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "uid": uid,
      "username": username,
      "likes": likes,
      "postId": postId,
      "datePublished": datePublished,
      "postUrl": postUrl,
      "profImage": profImage,
    };
  }
}
