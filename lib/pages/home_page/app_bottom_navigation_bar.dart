import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/pages/home_page/home_page.dart';
import 'package:provider/provider.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final animation = context.watch<PlayerAnimationManager>();

    return AnimatedBuilder(
      animation: animation.animation,
      builder: (context, child) => Align(
        alignment: Alignment.topCenter,
        heightFactor: 1 - animation.animation.value,
        child: child,
      ),
      child: BottomNavigationBar(
        currentIndex:
            context.select((HomePageState state) => state.currentIndex),
        onTap: (index) => context.read<HomePageState>().currentIndex = index,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Trending',
            icon: Icon(Icons.trending_up),
          ),
          BottomNavigationBarItem(
            label: 'Subscriptions',
            icon: Icon(Icons.subscriptions),
          ),
          BottomNavigationBarItem(
            label: 'Inbox',
            icon: Icon(Icons.mail),
          ),
          BottomNavigationBarItem(
            label: 'Library',
            icon: Icon(Icons.video_library),
          ),
        ],
        selectedFontSize: 12,
      ),
    );
  }
}
