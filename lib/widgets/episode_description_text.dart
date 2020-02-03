import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class EpisodeDescriptionText extends StatelessWidget {
  const EpisodeDescriptionText({
    Key key,
    @required this.episode,
  }) : super(key: key);

  final Episode episode;
  static final _viewsFormatter = NumberFormat.compact();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Text(
      '${episode.channel.name}・'
      '${_viewsFormatter.format(episode.views)} views・'
      '${timeago.format(episode.publishedAt)}',
      style: textTheme.caption,
    );
  }
}
