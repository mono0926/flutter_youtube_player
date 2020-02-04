import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/widgets/episode_description_text.dart';
import 'package:provider/provider.dart';

class EpisodePlayer extends StatelessWidget {
  const EpisodePlayer({Key key}) : super(key: key);

  static const _margin = 8.0;
  static const _bottomBarHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final notifier = context.watch<PlayerNotifier>();
    final shrinkedBottom =
        mediaQuery.padding.bottom + _bottomBarHeight + _margin;
    final shrinkedTop =
        mediaQuery.size.height - shrinkedBottom - _bottomBarHeight;
    final topDistance = shrinkedTop - mediaQuery.padding.top;
    return AnimatedBuilder(
      animation: notifier.expandingAnimation,
      builder: (context, child) {
        final expandedRatio = notifier.expandingAnimation.value;
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
        onTap: notifier.expand,
        onVerticalDragUpdate: (details) {
          final delta = -details.primaryDelta;
          notifier.addExpandingAnimation(delta / topDistance);
        },
        onVerticalDragEnd: (details) {
          final threshold =
              notifier.status == PlayerStatus.shrinked ? 0.3 : 0.7;
          if (notifier.expandingAnimation.value > threshold) {
            notifier.expand();
          } else {
            notifier.shrink();
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
    // Scaffoldで囲むとタップ効かなくなるがpadding無効化
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        body: Material(
          elevation: 2,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final aspectRatio = constraints.maxWidth / constraints.maxHeight;
              return aspectRatio >= 2.8
                  ? const _VideoRow()
                  : Column(
                      children: const [
                        _VideoRow(),
                        Expanded(
                          child: _Body(),
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

class _Body extends StatelessWidget {
  const _Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final episodeNotifier = context.watch<EpisodeNotifier>();
    final playerNotifier = context.watch<PlayerNotifier>();
    final episode = episodeNotifier.episode;
    return FadeTransition(
      opacity: playerNotifier.contentFadeAnimation,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(episode.title),
            subtitle: EpisodeDescriptionText(episode: episode),
            trailing: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.thumb_down),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.cloud_download),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.save_alt),
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              SizedBox(width: 16),
              CircleAvatar(
                backgroundImage: NetworkImage(episode.channel.imageUrl),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(episode.channel.name),
                  Text('${episode.channel.subscriberCount} subscribers'),
                ],
              ),
              Spacer(),
              FlatButton(
                textTheme: ButtonTextTheme.primary,
                child: Text('SUBSCRIBE'),
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              SizedBox(width: 16),
              Text('Up next'),
              Spacer(),
              Text('AutoPlay'),
              Switch(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
          _EpisodeTile(),
          _EpisodeTile(),
          _EpisodeTile(),
          _EpisodeTile(),
          _EpisodeTile(),
          _EpisodeTile(),
        ],
      ),
    );
  }
}

class _EpisodeTile extends StatelessWidget {
  const _EpisodeTile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final episode = Episode.example[1];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: AspectRatio(
        aspectRatio: 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(episode.thumbnailUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      episode.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    episode.channel.name,
                    maxLines: 1,
                  ),
                  Text('${episode.views}'),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
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
            const SizedBox(width: 48.0 * 3 + 4.0),
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
              icon: Icon(Icons.play_arrow),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {},
            )
          ],
        ),
        _Video(episode: episode),
      ],
    );
  }
}

class _Video extends StatelessWidget {
  const _Video({
    Key key,
    @required this.episode,
  }) : super(key: key);

  final Episode episode;

  static final _aspectTween = Tween<double>(begin: 3, end: 16 / 9);

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<PlayerNotifier>();
    return AnimatedBuilder(
      animation: notifier.expandingAnimation,
      builder: (context, child) {
        return AspectRatio(
          aspectRatio: _aspectTween.evaluate(notifier.expandingAnimation),
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
