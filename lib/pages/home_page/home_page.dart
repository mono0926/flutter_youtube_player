import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/util/util.dart';
import 'package:provider/provider.dart';

import 'episode_sliver_list.dart';
import 'header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

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
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _pages[_currentIndex],
    );
  }

  Widget _buildBottomNavigationBar() {
    final mediaQuery = MediaQuery.of(context);
    // TODO(mono): static化したい
    final tween = Tween(
      begin: Offset.zero,
      end: Offset(0, mediaQuery.padding.bottom + 48),
    );

    final notifier = context.watch<PlayerNotifier>();
    return AnimatedBuilder(
      animation: notifier.expandingAnimation,
      builder: (context, child) => Transform.translate(
        offset: tween.evaluate(notifier.expandingAnimation),
        child: child,
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            title: const Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: const Text('Trending'),
            icon: Icon(Icons.trending_up),
          ),
          BottomNavigationBarItem(
            title: const FittedBox(
              child: Text('Subscriptions'),
            ),
            icon: Icon(Icons.subscriptions),
          ),
          BottomNavigationBarItem(
            title: const Text('Inbox'),
            icon: Icon(Icons.mail),
          ),
          BottomNavigationBarItem(
            title: const Text('Library'),
            icon: Icon(Icons.video_library),
          ),
        ],
      ),
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
