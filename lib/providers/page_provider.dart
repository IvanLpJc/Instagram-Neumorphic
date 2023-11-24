import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class PageProvider extends ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage => _selectedPage;

  final PageController _pageController = PageController(initialPage: 0);

  set selectedPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
    _selectedPage = page;
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
