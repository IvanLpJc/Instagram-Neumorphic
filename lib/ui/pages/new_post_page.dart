import 'package:flutter/material.dart';

class NewPostPage extends StatelessWidget {
  static const String route = 'new_post_page';
  const NewPostPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('NewPostPage'),
      ),
    );
  }
}
