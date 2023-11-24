import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class LoadingPage extends StatefulWidget {
  static const String route = 'loading_page';
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double depth = -10;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = Tween(begin: -10.0, end: 10.0).animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        depth = _animation.value;
      });
    });

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }

      if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: depth,
            shape: NeumorphicShape.convex,
          ),
          child: Container(
            width: 300,
            height: 100,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Loading',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TyperAnimatedText('...',
                        speed: const Duration(milliseconds: 250),
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
