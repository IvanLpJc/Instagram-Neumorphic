import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
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
          child: NeumorphicSwitch(
            height: 20,
            style: NeumorphicSwitchStyle(
                activeTrackColor: Colors.blueGrey,
                inactiveTrackColor: Colors.blueGrey.shade200),
            value: !NeumorphicTheme.of(context)!.isUsingDark,
            onChanged: (value) {
              if (value) {
                NeumorphicTheme.of(context)?.themeMode = ThemeMode.light;
              } else {
                NeumorphicTheme.of(context)?.themeMode = ThemeMode.dark;
              }
              setState(() {});
            },
          ),
        ),
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
      // backgroundColor: themeProvider.currentThemeMode == ThemeMode.light
      //     ? themeProvider.baseColorLight
      //     : themeProvider.baseColorDark,
      backgroundColor: NeumorphicTheme.of(context)!.current!.baseColor,
    );
  }
}
