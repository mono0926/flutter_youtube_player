import 'package:flutter/material.dart';
import 'package:flutter_youtube_player/models/models.dart';
import 'package:flutter_youtube_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EpisodePlayerBody extends StatelessWidget {
  const EpisodePlayerBody({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<EpisodeNotifier>();
    final episode = notifier.episode;
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(episode.title),
          subtitle: EpisodeDescriptionText(episode: episode),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_drop_down),
            onPressed: () {},
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pressed'),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.thumb_down),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.cloud_download),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.save_alt),
              onPressed: () {},
            ),
          ],
        ),
        const Divider(),
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            CircleAvatar(
              backgroundImage: NetworkImage(episode.channel.imageUrl),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(episode.channel.name),
                Text('${episode.channel.subscriberCount} subscribers'),
              ],
            ),
            const Spacer(),
            TextButton(
              child: const Text('SUBSCRIBE'),
              onPressed: () {},
            ),
          ],
        ),
        const Divider(),
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            const Text('Up next'),
            const Spacer(),
            const Text('AutoPlay'),
            Switch(
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
        ...List.filled(10, const _EpisodeTile()),
      ],
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
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
