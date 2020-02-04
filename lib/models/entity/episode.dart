import 'package:flutter/foundation.dart';

@immutable
class Episode {
  const Episode({
    @required this.title,
    @required this.publishedAt,
    @required this.views,
    @required this.thumbnailUrl,
    @required this.videoUrl,
    @required this.channel,
  });
  final String title;
  final DateTime publishedAt;
  final int views;
  final String thumbnailUrl;
  final String videoUrl;
  final Channel channel;

  static final List<Episode> example = [
    Episode(
      title: 'monoさんのFlutter講座',
      publishedAt: DateTime(2019, 1, 5, 14, 30),
      views: 594382734029,
      thumbnailUrl:
          'https://dummyimage.com/480 x 270/4DD0FA/ffffff.png&text=Flutter',
      videoUrl:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      channel: const Channel(
        name: 'mono🐶',
        imageUrl: 'https://robohash.org/flutter',
        subscriberCount: 128957,
      ),
    ),
    Episode(
      title: 'ウォーレン・バフェットが語る、成功、最高の投資とは。',
      publishedAt: DateTime(2018, 1, 5, 14, 30),
      views: 176,
      thumbnailUrl:
          'https://dummyimage.com/480 x 270/cc6c9a/ffffff.png&text=ウォーレン',
      videoUrl:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      channel: const Channel(
        name: '未来完了形資産家JM',
        imageUrl: 'https://robohash.org/mono',
        subscriberCount: 532,
      ),
    ),
    Episode(
      title: '貴乃花　vs　朝青龍　「ガチ」',
      publishedAt: DateTime(2009, 2, 5, 14, 30),
      views: 11330217,
      thumbnailUrl:
          'https://dummyimage.com/480 x 270/ff6c9a/ffffff.png&text=相撲',
      videoUrl:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      channel: const Channel(
        name: 'Gentil Donna',
        imageUrl: 'https://robohash.org/apple',
        subscriberCount: 432,
      ),
    ),
  ];
}

@immutable
class Channel {
  const Channel({
    @required this.name,
    @required this.imageUrl,
    @required this.subscriberCount,
  });
  final String name;
  final String imageUrl;
  final int subscriberCount;
}
