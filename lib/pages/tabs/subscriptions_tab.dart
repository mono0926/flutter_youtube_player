import 'package:flutter/material.dart';

class SubscriptionsTab extends StatelessWidget {
  const SubscriptionsTab({Key key}) : super(key: key);

  static const routeName = '/subscriptions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions'),
      ),
    );
  }
}
