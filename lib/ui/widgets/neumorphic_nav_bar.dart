import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/helpers/helpers.dart';
import 'package:neumorphic_instagram/providers/page_provider.dart';
import 'package:provider/provider.dart';

class NeumorphicNavBar extends StatelessWidget {
  const NeumorphicNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PageProvider>(context);

    const avatar = CircleAvatar(
      radius: 12,
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage('assets/images/profile.jpg'),
    );

    final color = Styles.getBaseColor(context);

    final iconStyle = Styles.iconStyle(context);

    return NeumorphicToggle(
        height: 55,
        selectedIndex: provider.selectedPage,
        onChanged: (value) {
          provider.selectedPage = value;
        },
        children: [
          ToggleElement(
            foreground: NeumorphicIcon(
              Icons.home,
              size: 32,
              style: iconStyle,
            ),
            background: Center(
              child: NeumorphicIcon(
                Icons.home_outlined,
                size: 30,
                style: iconStyle,
              ),
            ),
          ),
          ToggleElement(
            foreground: NeumorphicIcon(
              Icons.search,
              size: 32,
              style: iconStyle,
            ),
            background: NeumorphicIcon(
              Icons.search_outlined,
              size: 30,
              style: iconStyle,
            ),
          ),
          ToggleElement(
              foreground: NeumorphicIcon(
                Icons.add_box,
                size: 32,
                style: iconStyle,
              ),
              background: NeumorphicIcon(
                Icons.add_box_outlined,
                size: 30,
                style: iconStyle,
              )),
          ToggleElement(
              foreground: NeumorphicIcon(
                Icons.movie,
                size: 32,
                style: iconStyle,
              ),
              background: NeumorphicIcon(Icons.movie_outlined,
                  size: 30, style: iconStyle)),
          ToggleElement(
            foreground: Neumorphic(
              style: Styles.avatarStyle(color: color),
              child: const CircleAvatar(
                radius: 14,
                child: avatar,
              ),
            ),
            background: Neumorphic(
              style: Styles.avatarStyle(color: color),
              child: const CircleAvatar(radius: 12, child: avatar),
            ),
          ),
        ],
        thumb: Container());
  }
}
