import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/theme.dart';

// TODO(mono): 完全に隠れた方のアニメーションを無効化したり(Visibility+α)
class PlayerNotifier with ChangeNotifier {
  PlayerNotifier({
    @required this.themeNotifier,
    @required this.tickerProvider,
  }) {
    _expandingAnimationController = AnimationController(
      vsync: tickerProvider,
      duration: duration,
    )..addListener(() {
        themeNotifier.appBarBrightness = _expandingEndAnimation.value == 0
            ? Brightness.light
            : Brightness.dark;
      });
    _expandingAnimation = _expandingAnimationController;
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
  }

  static const duration = Duration(milliseconds: 1000);
  final ThemeNotifier themeNotifier;
  final TickerProvider tickerProvider;
  AnimationController _expandingAnimationController;
  Animation<double> _expandingAnimation;
  Animation<double> _expandingEndAnimation;
  Animation<double> _expandingMiddleToEndAnimation;

  Animation<double> get expandingAnimation => _expandingAnimation;
  Animation<double> get expandingEndAnimation => _expandingEndAnimation;
  Animation<double> get expandingMiddleToEndAnimation =>
      _expandingMiddleToEndAnimation;

  var _status = PlayerStatus.shrinked;
  PlayerStatus get status => _status;

  // TODO(mono): nullにする
  Episode _episode = Episode.example.first;
  Episode get episode => _episode;
  set episode(Episode episode) {
    _episode = episode;
    notifyListeners();
  }

  void _initializeDefaultAnimation() {
    _expandingAnimationController.duration = duration;
    _expandingAnimation = _expandingAnimationController;
  }

  void addExpandingAnimation(double value) {
    _expandingAnimationController.value += value;
  }

  Future<void> shrink() async {
    _status = PlayerStatus.shrinked;
    final tween = Tween<double>(
      begin: 0,
      end: _expandingAnimationController.value,
    );
    final curve = CurveTween(curve: Curves.easeInOut);
    _expandingAnimationController.duration = Duration(
      milliseconds:
          (duration.inMilliseconds * (tween.end - tween.begin)).round(),
    );
    _expandingAnimation =
        _expandingAnimationController.drive(tween).drive(curve);
    await _expandingAnimationController.reverse(from: 1);
    _initializeDefaultAnimation();
  }

  Future<void> expand() async {
    _status = PlayerStatus.expanded;
    final tween = Tween<double>(
      begin: _expandingAnimationController.value,
      end: 1,
    );
    _expandingAnimationController.duration = Duration(
      milliseconds:
          (duration.inMilliseconds * (tween.end - tween.begin)).round(),
    );
    _expandingAnimation = _expandingAnimationController.drive(tween).drive(
          CurveTween(curve: Curves.easeOutExpo),
        );
    await _expandingAnimationController.forward(from: 0);
    _initializeDefaultAnimation();
  }
}

enum PlayerStatus {
  shrinked,
  expanded,
}
