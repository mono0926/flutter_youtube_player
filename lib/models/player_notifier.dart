import 'package:disposable_provider/disposable_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/theme.dart';

// TODO(mono): 完全に隠れた方のアニメーションを無効化したり(Visibility+α)
class PlayerAnimationManager implements Disposable {
  PlayerAnimationManager({
    @required this.themeNotifier,
    @required TickerProvider tickerProvider,
  }) : _animationController = AnimationController(
          vsync: tickerProvider,
          duration: duration,
        ) {
    _resetAnimationIfNeeded();
    _topFadeAnimation = _animationController.drive(
      CurveTween(
        curve: const Interval(0.8, 1),
      ),
    );
    _contentFadeAnimation = _animationController.drive(
      CurveTween(
        curve: const Interval(0.2, 1),
      ),
    );

    _animationController.addListener(() {
      themeNotifier.appBarBrightness =
          _topFadeAnimation.value == 0 ? Brightness.light : Brightness.dark;
    });
  }

  // TODO(mono): 200くらいが良い
  static const duration = Duration(milliseconds: 1000);
  final ThemeNotifier themeNotifier;
  final AnimationController _animationController;
  Animation<double> _animation;
  Animation<double> _topFadeAnimation;
  Animation<double> _contentFadeAnimation;

  Animation<double> get animation => _animation;
  Animation<double> get topFadeAnimation => _topFadeAnimation;
  Animation<double> get contentFadeAnimation => _contentFadeAnimation;

  var _status = PlayerStatus.shrinked;
  PlayerStatus get status => _status;

  void _resetAnimationIfNeeded() {
    if (_animation != _animationController) {
      _animation = _animationController;
    }
  }

  void addExpandingAnimation(double value) {
    _resetAnimationIfNeeded();
    _animationController.value += value;
  }

  Future<void> shrink() async {
    _status = PlayerStatus.shrinked;
    final tween = Tween<double>(
      begin: 0,
      end: _animationController.value,
    );
    _animation = _animationController
        .drive(
          CurveTween(
            curve: Interval(
              tween.begin,
              tween.end,
              curve: Curves.easeInCirc,
            ),
          ),
        )
        .drive(tween);
    await _animationController.reverse();
    _resetAnimationIfNeeded();
  }

  Future<void> expand() async {
    _status = PlayerStatus.expanded;
    final tween = Tween<double>(
      begin: _animationController.value,
      end: 1,
    );
    _animation = _animationController
        .drive(
          CurveTween(
            curve: Interval(
              tween.begin,
              tween.end,
              curve: Curves.easeOutExpo,
            ),
          ),
        )
        .drive(tween);
    await _animationController.forward();
    _resetAnimationIfNeeded();
  }

  @override
  void dispose() {
    _animationController.dispose();
  }
}

enum PlayerStatus {
  shrinked,
  expanded,
}
