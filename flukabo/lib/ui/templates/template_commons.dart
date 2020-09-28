import 'package:flutter/material.dart';

class TitleTemplate extends StatelessWidget {
  final String text;
  final Color color;
  const TitleTemplate({
    @required this.text,
    @required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${text}_title",
      child: Material(
        color: Colors.transparent,
        child: Text(
          text,
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
