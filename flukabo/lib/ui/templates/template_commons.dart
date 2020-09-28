import 'package:flutter/material.dart';

class TitleTemplate extends StatelessWidget {
  final int objectId;
  final String title;
  final Color color;
  const TitleTemplate({
    @required this.objectId,
    @required this.title,
    @required this.color,
  });
  @override
  Widget build(BuildContext context) {
    String content = title;
    if (title.length > 60) {
      content = '${title.substring(0, 57)}...';
    }
    return Hero(
      tag: "$title-$objectId-title",
      child: Material(
        color: Colors.transparent,
        child: Text(
          content,
          style: TextStyle(
            letterSpacing: 1.1,
            color: color,
          ),
        ),
      ),
    );
  }
}

class SubtitleTemplate extends StatelessWidget {
  final String subtitle;
  const SubtitleTemplate({@required this.subtitle});
  @override
  Widget build(BuildContext context) {
    String content = subtitle;
    if (subtitle.length > 100) {
      content = '${subtitle.substring(0, 97)}...';
    }
    return Text(content);
  }
}
