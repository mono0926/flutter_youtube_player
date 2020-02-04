import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  static const routeName = '/account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
    );
  }
}
