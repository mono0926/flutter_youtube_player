import 'package:flutter/material.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({Key key}) : super(key: key);

  static const routeName = '/library';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
    );
  }
}
