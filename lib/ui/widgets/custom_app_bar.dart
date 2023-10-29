import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SliverAppBar(
      floating: true,
      snap: true,
      leadingWidth: 150,
      leading: NeumorphicButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NeumorphicText(
              'For you',
              style: const NeumorphicStyle(
                color: Colors.black87, //customize color here
              ),
              textStyle: NeumorphicTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            NeumorphicIcon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
              style: const NeumorphicStyle(color: Colors.black),
            )
          ],
        ),
      ),
      actions: [
        Center(
          child: NeumorphicButton(
            child: NeumorphicIcon(
              Icons.favorite_border_outlined,
              size: 27,
              style: const NeumorphicStyle(color: Colors.black),
            ),
          ),
        ),
        Center(
          child: NeumorphicButton(
            child: NeumorphicIcon(Icons.send_outlined,
                size: 27, style: const NeumorphicStyle(color: Colors.black)),
          ),
        ),
      ],
      backgroundColor: themeProvider.currentThemeMode == ThemeMode.light
          ? themeProvider.baseColorLight
          : themeProvider.baseColorDark,
    );
  }
}
