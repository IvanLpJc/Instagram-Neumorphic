import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CustomAppBar extends StatefulWidget {
  final Function() onTap;
  const CustomAppBar({super.key, required this.onTap});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

const List<String> list = <String>['For you', 'Two', 'Three', 'Four'];

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final color = NeumorphicTheme.of(context)!.isUsingDark
        ? const NeumorphicThemeData().baseColor
        : const NeumorphicThemeData.dark().baseColor;
    return SliverAppBar(
      floating: true,
      snap: true,
      leadingWidth: 150,
      leading: NeumorphicButton(
        child: InkWell(
          onTap: widget.onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NeumorphicText(
                'For you',
                style: NeumorphicStyle(
                  color: color, //customize color here
                ),
                textStyle: NeumorphicTextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              NeumorphicIcon(
                Icons.keyboard_arrow_down_outlined,
                size: 30,
                style: NeumorphicStyle(color: color),
              )
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: NeumorphicButton(
            padding: EdgeInsets.zero,
            child: NeumorphicIcon(
              Icons.favorite_border_outlined,
              size: 27,
              style: NeumorphicStyle(color: color),
            ),
          ),
        ),
        Center(
          child: NeumorphicButton(
            child: NeumorphicIcon(Icons.send_outlined,
                size: 27, style: NeumorphicStyle(color: color)),
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
