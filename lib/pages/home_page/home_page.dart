import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/pages/episode_player/episode_player.dart';
import 'package:flutter_youtube_player/pages/home_page/app_bottom_navigation_bar.dart';
import 'package:flutter_youtube_player/pages/tabs/home_tab/home_tab.dart';
import 'package:flutter_youtube_player/pages/tabs/inbox_tab.dart';
import 'package:flutter_youtube_player/pages/tabs/library_tab.dart';
import 'package:flutter_youtube_player/pages/tabs/subscriptions_tab.dart';
import 'package:flutter_youtube_player/pages/tabs/trending_tab.dart';
import 'package:provider/provider.dart';
import 'package:touch_indicator/touch_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage._({Key key}) : super(key: key);

  static Widget wrapped() {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: const HomePage._(),
    );
  }

  // TODO(mono): Keep state
  static const _pages = {
    0: HomeTab(),
    1: TrendingTab(),
    2: SubscriptionsTab(),
    3: InboxTab(),
    4: LibraryTab(),
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          bottomNavigationBar: const AppBottomNavigationBar(),
          body: _pages[
              context.select((HomePageState state) => state.currentIndex)],
        ),
        const _FadeScreen(),
        TouchIndicator(
          child: const EpisodePlayer(),
        ),
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

class _FadeScreen extends StatelessWidget {
  const _FadeScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<PlayerNotifier>();
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            bottom: null,
            child: FadeTransition(
              opacity: notifier.topFadeAnimation,
              child: Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.black,
              ),
            ),
          ),
          FadeTransition(
            opacity: notifier.overallFadeAnimation,
            child: Container(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
