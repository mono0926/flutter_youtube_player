import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/pages/episode_player/episode_player_body.dart';
import 'package:provider/provider.dart';

const _shrinkedHeight = 50.0;
const _shrinkedAspectRatio = 2.5;

class EpisodePlayer extends StatelessWidget {
  const EpisodePlayer({Key key}) : super(key: key);

  static const _margin = 8.0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final animation = context.watch<PlayerAnimationManager>();
    final shrinkedBottom =
        mediaQuery.padding.bottom + kBottomNavigationBarHeight + _margin;
    final shrinkedTop =
        mediaQuery.size.height - (shrinkedBottom + _shrinkedHeight);
    final topDistance = shrinkedTop - mediaQuery.padding.top;
    return AnimatedBuilder(
      animation: animation.animation,
      builder: (context, child) {
        final expandedRatio = animation.animation.value;
        final top = shrinkedTop - topDistance * expandedRatio;
        final margin = (1 - expandedRatio) * _margin;
        final bottom = (1 - expandedRatio) * shrinkedBottom;
        return Positioned(
          top: top,
          left: margin,
          right: margin,
          bottom: bottom,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: animation.expand,
        onVerticalDragUpdate: (details) {
          final delta = -details.primaryDelta;
          animation.addAnimationValue(delta / topDistance);
        },
        onVerticalDragEnd: (details) {
          final threshold =
              animation.status == PlayerStatus.shrinked ? 0.3 : 0.7;
          if (animation.animation.value > threshold) {
            animation.expand();
          } else {
            animation.shrink();
          }
        },
        child: const _Home(),
      ),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final animation = context.watch<PlayerAnimationManager>();
    // padding.topにマージンを設けているのでSafeArea無効化すると都合が良い
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        primary: false,
        body: Material(
          elevation: 2,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final aspectRatio = constraints.maxWidth / constraints.maxHeight;
              return aspectRatio > _shrinkedAspectRatio - 0.2
                  ? const _VideoRow()
                  : Column(
                      children: [
                        const _Video(),
                        Expanded(
                          child: FadeTransition(
                            opacity: animation.contentFadeAnimation,
                            child: const EpisodePlayerBody(),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _VideoRow extends StatelessWidget {
  const _VideoRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EpisodeNotifier>();
    final episode = notifier.episode;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Stack(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(width: _shrinkedHeight * _shrinkedAspectRatio + 4.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    episode.title,
                    maxLines: 1,
                    style: textTheme.caption,
                  ),
                  Text(
                    episode.channel.name,
                    maxLines: 1,
                    style: textTheme.overline,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
            )
          ],
        ),
        const _Video(),
      ],
    );
  }
}

class _Video extends StatelessWidget {
  const _Video({Key key}) : super(key: key);

  static final _aspectTween = Tween<double>(
    begin: _shrinkedAspectRatio,
    end: 16 / 9,
  );

  @override
  Widget build(BuildContext context) {
    final episodeNotifier = context.watch<EpisodeNotifier>();
    final episode = episodeNotifier.episode;
    final animation = context.watch<PlayerAnimationManager>();
    return AnimatedBuilder(
      animation: animation.animation,
      builder: (context, child) {
        return AspectRatio(
          aspectRatio: _aspectTween.evaluate(animation.animation),
          child: child,
        );
      },
      child: Image.network(
        episode.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
