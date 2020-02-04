import 'package:flutter/material.dart';

class OriginalsPage extends StatelessWidget {
  const OriginalsPage({Key key}) : super(key: key);

  static const routeName = '/originals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Originals'),
      ),
    );
  }
}
