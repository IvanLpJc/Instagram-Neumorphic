import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/models/photo.dart';
import 'package:neumorphic_instagram/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
    required Photo photo,
  }) : _photo = photo;

  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: width,
      child: Neumorphic(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FancyShimmerImage(
                  imageUrl: _photo.url,
                  height: 546,
                  boxFit: BoxFit.fill,
                  width: width,
                ),
                Positioned(
                  top: 4,
                  child: _TopBar(width: width, photo: _photo),
                ),
              ],
            ),
            _Description(photo: _photo)
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.width,
    required Photo photo,
  }) : _photo = photo;

  final double width;
  final Photo _photo;

  final avatarStyle = const NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.circle(),
      lightSource: LightSource.topLeft,
      color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Neumorphic(
            style: avatarStyle,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage(_photo.url),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          NeumorphicText(
            _photo.photographer,
            style: const NeumorphicStyle(
              color: Colors.black,
            ),
            textStyle: NeumorphicTextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Spacer(),
          NeumorphicButton(
            style: const NeumorphicStyle(color: Colors.transparent),
            child: NeumorphicIcon(
              Icons.more_vert_rounded,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.currentThemeMode == ThemeMode.light
        ? themeProvider.baseColorDark
        : themeProvider.baseColorLight;
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 10, top: 5, right: 15),
      child: Row(
        children: [
          NeumorphicIcon(
            Icons.favorite_border_outlined,
            size: 30,
            style: NeumorphicStyle(color: color),
          ),
          const SizedBox(
            width: 10,
          ),
          NeumorphicIcon(
            Icons.send_outlined,
            size: 28,
            style: NeumorphicStyle(color: color),
          ),
          const Spacer(),
          NeumorphicIcon(
            Icons.save_outlined,
            size: 28,
            style: NeumorphicStyle(color: color),
          ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required Photo photo,
  }) : _photo = photo;

  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color = themeProvider.currentThemeMode == ThemeMode.light
        ? themeProvider.baseColorDark
        : themeProvider.baseColorLight;
    return SizedBox(
      width: width,
      child: Neumorphic(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Actions(width: width),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: RichText(
                text: TextSpan(
                  text: '${_photo.photographer} ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  children: [
                    TextSpan(
                        text: _photo.alt,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: color))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
