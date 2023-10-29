import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/providers/pexels_provider.dart';
import 'package:neumorphic_instagram/providers/theme_provider.dart';
import 'package:neumorphic_instagram/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => PexelsProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return NeumorphicApp(
        title: 'Neuromorphic Instagram',
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.currentThemeMode,
        theme: NeumorphicThemeData(
          baseColor: themeProvider.baseColorLight,
          lightSource: LightSource.bottomLeft,
          depth: 1.5,
        ),
        darkTheme: NeumorphicThemeData(
          baseColor: themeProvider.baseColorDark,
          lightSource: LightSource.bottomLeft,
          depth: 1.5,
        ),
        home: const HomePage());
  }
}
