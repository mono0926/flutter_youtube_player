import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/widgets/widgets.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key key,
    @required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildThumbnail(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 12),
              _buildChannelIcon(),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(episode.title),
                    EpisodeDescriptionText(episode: episode),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChannelIcon() {
    return CircleAvatar(
      maxRadius: 18,
      backgroundImage: NetworkImage(episode.channel.imageUrl),
    );
  }

  Widget _buildThumbnail() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        episode.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
