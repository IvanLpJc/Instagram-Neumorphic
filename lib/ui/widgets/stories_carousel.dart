import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class StoriesCarrousel extends StatelessWidget {
  const StoriesCarrousel({
    super.key,
  });

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
              itemCount: 10,
              itemBuilder: (_, index) {
                return const _Story();
              }),
        ),
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Neumorphic(
            style: const NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 1.5,
                lightSource: LightSource.topLeft,
                color: Colors.grey),
            child: CircleAvatar(
              radius: 46,
              backgroundColor: Colors.blueGrey.shade600,
              child: const CircleAvatar(
                radius: 44,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          NeumorphicText(
            'Your story',
            style: const NeumorphicStyle(
              color: Colors.black87, //customize color here
            ),
            textStyle: NeumorphicTextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
