import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/theme.dart';

// TODO(mono): 完全に隠れた方のアニメーションを無効化したり(Visibility+α)
class PlayerNotifier with ChangeNotifier {
  PlayerNotifier({
    @required this.themeNotifier,
    @required TickerProvider tickerProvider,
  }) {
    _expandingAnimationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
    _expandingEndAnimation = _expandingAnimationController.drive(
      CurveTween(
        curve: const Interval(0.8, 1),
      ),
    );
    _expandingMiddleToEndAnimation = _expandingAnimationController.drive(
      CurveTween(
        curve: const Interval(0.2, 1),
      ),
    );
    _expandingEndAnimation.addListener(() {
      themeNotifier.appBarBrightness = _expandingEndAnimation.value == 0
          ? Brightness.light
          : Brightness.dark;
    });
  }

  final ThemeNotifier themeNotifier;
  AnimationController _expandingAnimationController;
  Animation<double> _expandingEndAnimation;
  Animation<double> _expandingMiddleToEndAnimation;

  Animation<double> get expandingAnimation => _expandingAnimationController;
  Animation<double> get expandingEndAnimation => _expandingEndAnimation;
  Animation<double> get expandingMiddleToEndAnimation =>
      _expandingMiddleToEndAnimation;

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
