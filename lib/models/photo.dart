import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class Photo {
  int id;
  int width;
  int height;
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  bool liked;
  Color avgColor;
  String alt;

  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.liked,
    required this.avgColor,
    required this.alt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["src"]["portrait"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        photographerId: json["photographer_id"],
        liked: json["liked"],
        avgColor:
            Color(int.parse('0xff${json["avg_color"].replaceAll("#", "")}')),
        alt: json["alt"],
      );
}
