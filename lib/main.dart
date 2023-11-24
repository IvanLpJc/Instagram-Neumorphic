import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neumorphic_instagram/preferences/preferences.dart';
import 'package:provider/provider.dart';

import 'package:neumorphic_instagram/providers/providers.dart';
import 'package:neumorphic_instagram/ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => PexelsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),
    ],
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final pexelsProvider = Provider.of<PexelsProvider>(context);

    return NeumorphicApp(
        title: 'Neumorphic Instagram',
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.currentThemeMode,
        theme: const NeumorphicThemeData(
          baseColor: Color(0xFFE0DEE0),
          lightSource: LightSource.bottomLeft,
          depth: 1.5,
        ),
        darkTheme: const NeumorphicThemeData(
          baseColor: Color(0xFF2E2E2E),
          lightSource: LightSource.bottomLeft,
          depth: 1.5,
        ),
        home:
            pexelsProvider.isLoading ? const LoadingPage() : const HomePage());
  }
}
