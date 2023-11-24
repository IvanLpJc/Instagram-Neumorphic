class Comment {
  int id;
  String username;
  String comment;

  Comment({
    required this.id,
    required this.username,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        username: json["username"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "comment": comment,
      };
}
