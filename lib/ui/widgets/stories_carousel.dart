import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/helpers/helpers.dart';
import 'package:neumorphic_instagram/models/photo.dart';

class StoriesCarrousel extends StatelessWidget {
  final List<Photo> stories;
  const StoriesCarrousel({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Neumorphic(
        style: const NeumorphicStyle(
            lightSource: LightSource.bottomLeft,
            boxShape: NeumorphicBoxShape.rect()),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 115,
          width: double.infinity,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (_, index) {
                return _Story(story: stories[index]);
              }),
        ),
      ),
    );
  }
}

class _Story extends StatelessWidget {
  final Photo story;
  const _Story({required this.story});

  @override
  Widget build(BuildContext context) {
    final color = NeumorphicTheme.of(context)!.isUsingDark
        ? const NeumorphicThemeData().baseColor
        : const NeumorphicThemeData.dark().baseColor;
    return Container(
      margin: const EdgeInsets.only(left: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Neumorphic(
            style: Styles.avatarStyle(color: color, borderWith: 3),
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.transparent,
              child: FancyShimmerImage(
                imageUrl: story.url,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          NeumorphicText(
            story.photographer,
            style: NeumorphicStyle(
              color: color, //customize color here
            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
