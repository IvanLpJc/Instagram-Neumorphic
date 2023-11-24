import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class Styles {
  static NeumorphicStyle avatarStyle(
          {required Color color, double borderWith = 1}) =>
      NeumorphicStyle(
          shape: NeumorphicShape.concave,
          border: NeumorphicBorder(color: color, width: borderWith),
          boxShape: const NeumorphicBoxShape.circle(),
          depth: 1.5,
          lightSource: LightSource.topLeft,
          color: Colors.grey);

  static Color getBaseColor(BuildContext context) =>
      NeumorphicTheme.of(context)!.isUsingDark
          ? const NeumorphicThemeData().baseColor
          : const NeumorphicThemeData.dark().baseColor;

  static NeumorphicStyle iconStyle(BuildContext context) =>
      NeumorphicStyle(color: getBaseColor(context), depth: 1.5);

  static Color getFontColorFromReference(Color background) {
    return (background.computeLuminance() < 0.149)
        ? const NeumorphicThemeData().baseColor
        : const NeumorphicThemeData.dark().baseColor;
  }
}
