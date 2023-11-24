import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/helpers/helpers.dart';
import 'package:neumorphic_instagram/providers/providers.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const String route = 'profile_page';
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NeumorphicIcon(
              Icons.light_mode_outlined,
              style: NeumorphicStyle(color: Styles.getBaseColor(context)),
            ),
            const SizedBox(
              width: 5,
            ),
            NeumorphicSwitch(
              height: 20,
              style: NeumorphicSwitchStyle(
                  activeTrackColor: Colors.blueGrey,
                  inactiveTrackColor: Colors.blueGrey.shade200),
              value: Provider.of<ThemeProvider>(context).isDarkTheme,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false).isDarkTheme =
                    value;
              },
            ),
            const SizedBox(
              width: 5,
            ),
            NeumorphicIcon(
              Icons.dark_mode_outlined,
              style: NeumorphicStyle(color: Styles.getBaseColor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
