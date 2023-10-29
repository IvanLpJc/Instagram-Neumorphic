import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  static const String route = 'explore_page';
  const ExplorePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('ExplorePage'),
      ),
    );
  }
}
