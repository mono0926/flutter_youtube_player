import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  void _resetAnimation() {
    _expandingAnimation = _expandingAnimationController;
  }

  void addExpandingAnimation(double value) {
    _expandingAnimationController.value += value;
    _fadeAnimationController.value += value;
  }

  Future<void> shrink() async {
    _status = PlayerStatus.shrinked;
    _expandingAnimation = _expandingAnimationController
        .drive(
          CurveTween(
            curve: Interval(
              0,
              _expandingAnimationController.value,
              curve: Curves.easeInCirc,
            ),
          ),
        )
        .drive(
          Tween<double>(
            begin: 0,
            end: _expandingAnimationController.value,
          ),
        );
    _fadeAnimationController.reverse();
    await _expandingAnimationController.reverse();
    _resetAnimation();
  }

  Future<void> expand() async {
    _status = PlayerStatus.expanded;
    _expandingAnimation = _expandingAnimationController
        .drive(
          CurveTween(
            curve: Interval(
              _fadeAnimationController.value,
              1,
              curve: Curves.easeOutExpo,
            ),
          ),
        )
        .drive(
          Tween<double>(
            begin: _fadeAnimationController.value,
            end: 1,
          ),
        );
    _fadeAnimationController.forward();
    await _expandingAnimationController.forward();
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
