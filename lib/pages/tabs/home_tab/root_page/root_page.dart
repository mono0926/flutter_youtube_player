import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/pages/account_page.dart';
import 'package:flutter_youtube_player/util/util.dart';

import '../header.dart';
import 'episode_sliver_list.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);

  static const routeName = 'home/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _Title(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cast),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          const _ProfileIconButton(),
        ],
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Header(),
          ),
          EpisodeSliverList(),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Images.youtube,
        const SizedBox(width: 4),
        const Text('Premium'),
      ],
    );
  }
}

class _ProfileIconButton extends StatelessWidget {
  const _ProfileIconButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const AspectRatio(
        aspectRatio: 1,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://mono0926.com/images/love_logo.png',
          ),
        ),
      ),
      onPressed: () => Navigator.of(
        context,
        rootNavigator: true,
      ).pushNamed(AccountPage.routeName),
    );
  }
}
