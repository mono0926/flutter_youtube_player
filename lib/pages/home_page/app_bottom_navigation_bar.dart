import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/pages/home_page/home_page.dart';
import 'package:provider/provider.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<PlayerNotifier>();
    final expandingAnimation = notifier.expandingAnimation;

    return AnimatedBuilder(
      animation: expandingAnimation,
      builder: (context, child) => Align(
        alignment: Alignment.topCenter,
        heightFactor: 1 - expandingAnimation.value,
        child: child,
      ),
      child: BottomNavigationBar(
        currentIndex:
            context.select((HomePageState state) => state.currentIndex),
        onTap: (index) => context.read<HomePageState>().currentIndex = index,
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
