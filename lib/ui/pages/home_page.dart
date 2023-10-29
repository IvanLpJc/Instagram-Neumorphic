import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'package:neumorphic_instagram/providers/page_provider.dart';
import 'package:neumorphic_instagram/ui/pages/pages.dart';
import 'package:neumorphic_instagram/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static const String route = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageProvider(),
      child: Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: const _MainBody(),
        bottomNavigationBar: const NeumorphicNavBar(),
      ),
    );
  }
}

class _MainBody extends StatefulWidget {
  const _MainBody();

  @override
  State<_MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<_MainBody> {
  final pages = [
    const FeedPage(),
    const ExplorePage(),
    const NewPostPage(),
    const ReelsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PageProvider>(context, listen: false);
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: provider.pageController,
      children: pages,
    );
  }
}
