import 'package:flutter/material.dart';

class TrendingTab extends StatelessWidget {
  const TrendingTab({Key key}) : super(key: key);

  static const routeName = '/trending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending'),
      ),
    );
  }
}
