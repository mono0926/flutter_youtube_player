import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';

import '../../../home_page/episode_card.dart';

class EpisodeSliverList extends StatelessWidget {
  const EpisodeSliverList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final episodes = Episode.example;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final episode = episodes[index];
          return EpisodeCard(
            episode: episode,
          );
        },
        childCount: episodes.length,
      ),
    );
  }
}
