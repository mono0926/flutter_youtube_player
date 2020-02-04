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
    );
    _fadeAnimationController = AnimationController(
      vsync: tickerProvider,
      duration: duration,
    )..addListener(() {
        themeNotifier.appBarBrightness =
            _topFadeAnimation.value == 0 ? Brightness.light : Brightness.dark;
        print(expandingAnimation.value);
      });
    _expandingAnimation = _expandingAnimationController;
    _topFadeAnimation = _fadeAnimationController.drive(
      CurveTween(
        curve: const Interval(0.8, 1),
      ),
    );
    _contentFadeAnimation = _fadeAnimationController.drive(
      CurveTween(
        curve: const Interval(0.2, 1),
      ),
    );
  }

  static const duration = Duration(milliseconds: 1000);
  final ThemeNotifier themeNotifier;
  final TickerProvider tickerProvider;
  AnimationController _expandingAnimationController;
  AnimationController _fadeAnimationController;
  Animation<double> _expandingAnimation;
  Animation<double> _topFadeAnimation;
  Animation<double> _contentFadeAnimation;

  Animation<double> get expandingAnimation => _expandingAnimation;
  Animation<double> get topFadeAnimation => _topFadeAnimation;
  Animation<double> get contentFadeAnimation => _contentFadeAnimation;
  Animation<double> get overallFadeAnimation => _fadeAnimationController;

  var _status = PlayerStatus.shrinked;
  PlayerStatus get status => _status;

  // TODO(mono): nullにする
  Episode _episode = Episode.example.first;
  Episode get episode => _episode;
  set episode(Episode episode) {
    _episode = episode;
    notifyListeners();
  }

  void _resetAnimation() {
    _expandingAnimationController.duration = duration;
    _expandingAnimation = _expandingAnimationController;
  }

  void addExpandingAnimation(double value) {
    _expandingAnimationController.value += value;
    _fadeAnimationController.value += value;
  }

  Future<void> shrink() async {
    _status = PlayerStatus.shrinked;
    final tween = Tween<double>(
      begin: 0,
      end: _expandingAnimationController.value,
    );
    _expandingAnimationController.duration = Duration(
      milliseconds:
          (duration.inMilliseconds * (tween.end - tween.begin)).round(),
    );
    _expandingAnimation = _expandingAnimationController
        .drive(CurveTween(curve: Curves.easeInCirc))
        .drive(tween);
    _fadeAnimationController.reverse();
    await _expandingAnimationController.reverse(from: 1);
    _resetAnimation();
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
    _expandingAnimation = _expandingAnimationController
        .drive(CurveTween(curve: Curves.easeOutExpo))
        .drive(tween);
    _fadeAnimationController.forward();
    await _expandingAnimationController.forward(from: 0);
    _resetAnimation();
  }

  @override
  void dispose() {
    _expandingAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }
}

enum PlayerStatus {
  shrinked,
  expanded,
}
