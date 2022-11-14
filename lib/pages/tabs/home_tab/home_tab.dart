import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/pages/tabs/home_tab/originals_page.dart';
import 'package:flutter_youtube_player/pages/tabs/home_tab/root_page/root_page.dart';
import 'package:flutter_youtube_player/router.dart';
import 'package:flutter_youtube_player/util/util.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  static final _routes = <String, WidgetPageBuilder>{
    RootPage.routeName: (context, settings) => const RootPage(),
    OriginalsPage.routeName: (context, settings) => const OriginalsPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: RootPage.routeName,
      onGenerateRoute: (settings) {
        final routeName = settings.name;
        logger.info(routeName);
        final pageBuilder = _routes[routeName];
        return routeName == RootPage.routeName
            ? PageRouteBuilder<void>(
                pageBuilder: (context, a1, a2) {
                  return pageBuilder(context, settings);
                },
              )
            : MaterialPageRoute<void>(
                builder: (context) => pageBuilder(context, settings),
              );
      },
    );
  }
}
