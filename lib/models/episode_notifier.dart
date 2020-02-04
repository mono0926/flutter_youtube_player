import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';

class EpisodeNotifier with ChangeNotifier {
  // TODO(mono): nullにする
  Episode _episode = Episode.example.first;
  Episode get episode => _episode;
  set episode(Episode episode) {
    _episode = episode;
    notifyListeners();
  }
}
