import 'dart:convert';

import 'package:neumorphic_instagram/models/photo.dart';

PexelResponse pexelResponseFromJson(String str) =>
    PexelResponse.fromJson(json.decode(str));

class PexelResponse {
  int page;
  int perPage;
  List<Photo> photos;
  String nextPage;

  PexelResponse({
    required this.page,
    required this.perPage,
    required this.photos,
    required this.nextPage,
  });

  factory PexelResponse.fromJson(Map<String, dynamic> json) => PexelResponse(
        page: json["page"],
        perPage: json["per_page"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        nextPage: json["next_page"],
      );
}
