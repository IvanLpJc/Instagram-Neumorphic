// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:neumorphic_instagram/models/post.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String username;
  String fullName;
  String email;
  String profilePic;
  int followers;
  int following;
  List<Post> posts;

  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.profilePic,
    required this.followers,
    required this.following,
    required this.posts,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["fullName"],
        email: json["email"],
        profilePic: json["profilePic"],
        followers: json["followers"],
        following: json["following"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullName": fullName,
        "email": email,
        "profilePic": profilePic,
        "followers": followers,
        "following": following,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}
