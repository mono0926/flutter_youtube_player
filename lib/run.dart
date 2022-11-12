import 'package:flutter/widgets.dart';
import 'package:flutter_youtube_player/models/episode_notifier.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'theme.dart';

void run() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Router()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(
          create: (context) => EpisodeNotifier(),
        )
      ],
      child: const App(),
    ),
  );
}
