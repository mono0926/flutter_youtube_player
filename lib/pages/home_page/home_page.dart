import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/app.dart';
import 'package:flutter_youtube_player/pages/episode_player/episode_player.dart';
import 'package:flutter_youtube_player/pages/home_page/app_bottom_navigation_bar.dart';
import 'package:flutter_youtube_player/pages/tabs/home_tab/home_tab.dart';
import 'package:flutter_youtube_player/pages/tabs/inbox_tab.dart';
import 'package:flutter_youtube_player/pages/tabs/library_tab.dart';
import 'package:flutter_youtube_player/pages/tabs/subscriptions_tab.dart';
import 'package:flutter_youtube_player/pages/tabs/trending_tab.dart';
import 'package:provider/provider.dart';

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
        const FadeScreen(),
        const EpisodePlayer(),
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
