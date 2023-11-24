import 'package:neumorphic_instagram/models/comment.dart';

class Post {
  int id;
  String image;
  String description;
  int likes;
  List<Comment> comments;

  Post({
    required this.id,
    required this.image,
    required this.description,
    required this.likes,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        image: json["image"],
        description: json["description"],
        likes: json["likes"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "description": description,
        "likes": likes,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}
