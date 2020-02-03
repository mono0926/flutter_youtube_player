import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/pages/home_page/app_bottom_navigation_bar.dart';
import 'package:flutter_youtube_player/util/util.dart';
import 'package:provider/provider.dart';

import 'episode_sliver_list.dart';
import 'header.dart';

class HomePage extends StatelessWidget {
  const HomePage._({Key key}) : super(key: key);

  static Widget wrapped() {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: const HomePage._(),
    );
  }

  static const _pages = {
    0: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Header(),
        ),
        EpisodeSliverList(),
      ],
    ),
    1: Text('Trending'),
    2: Text('Subscriptions'),
    3: Text('Inbox'),
    4: Text('Library'),
  };

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
      bottomNavigationBar: const AppBottomNavigationBar(),
      body: _pages[context.select((HomePageState state) => state.currentIndex)],
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
      onPressed: () {},
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

class HomePageState with ChangeNotifier {
  var _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
