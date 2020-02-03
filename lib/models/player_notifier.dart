import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_youtube_player/models/models.dart';

// TODO(mono): 完全に隠れた方のアニメーションを無効化したり(Visibility+α)
class PlayerNotifier with ChangeNotifier {
  PlayerNotifier({
    @required TickerProvider tickerProvider,
  }) : _expandingAnimationController = AnimationController(
          vsync: tickerProvider,
          duration: const Duration(
            milliseconds: 200,
          ),
        );

  final AnimationController _expandingAnimationController;

  Animation<double> get expandingAnimation => _expandingAnimationController;

  // TODO(mono): nullにする
  Episode _episode = Episode.example.first;
  Episode get episode => _episode;
  set episode(Episode episode) {
    _episode = episode;
    notifyListeners();
  }

  void addExpandingAnimation(double value) {
    _expandingAnimationController.value += value;
  }

  void shrink() {
    _expandingAnimationController.reverse();
  }

  void expand() {
    _expandingAnimationController.forward();
  }
}
