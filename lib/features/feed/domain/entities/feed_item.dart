import 'package:xml/xml.dart';

class FeedItem {
  final String title;
  final String description;
  final String imageUrl;
  final String linkUrl;

  FeedItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.linkUrl,
  });

  FeedItem copyWith({
    String? title,
    String? description,
    String? imageUrl,
    String? linkUrl,
  }) {
    return FeedItem(
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      linkUrl: linkUrl ?? this.linkUrl,
    );
  }

  factory FeedItem.fromXml(XmlElement item) {
    try {
      final title = item.findElements('title').single.innerText;
      final description = item.findElements('description').single.innerText;
      final imageUrl = item.findElements('media:thumbnail').single.getAttribute('url') ?? '';
      final linkUrl = item.findElements('link').single.innerText;

      return FeedItem(
        title: title,
        description: description,
        imageUrl: imageUrl,
        linkUrl: linkUrl,
      );
    } catch (e) {
      return FeedItem(
        title: '',
        description: '',
        imageUrl: '',
        linkUrl: '',
      );
    }
  }
}
