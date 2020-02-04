import 'package:flutter/material.dart';

class InboxTab extends StatelessWidget {
  const InboxTab({Key key}) : super(key: key);

  static const routeName = '/inbox';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
    );
  }
}
