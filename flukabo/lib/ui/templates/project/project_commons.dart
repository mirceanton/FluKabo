import 'package:flutter/material.dart';

class ProjectTitle extends StatelessWidget {
  final String text;
  final Color color;
  const ProjectTitle({
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

class ProjectSubtitle extends StatelessWidget {
  final String subtitle;
  const ProjectSubtitle({@required this.subtitle});
  @override
  Widget build(BuildContext context) {
    String content = subtitle;
    if (subtitle.length > 100) {
      content = '${subtitle.substring(0, 97)}...';
    }
    return Text(content);
  }
}

class ProjectBackground extends StatelessWidget {
  final String title;
  final double radius;
  final double width, height;
  final String image;
  const ProjectBackground({
    @required this.title,
    @required this.radius,
    @required this.height,
    @required this.width,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Hero(
        tag: "${title}_img",
        child: Image.network(
          image,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProjectStarIcon extends StatelessWidget {
  final bool isStarred;
  const ProjectStarIcon({@required this.isStarred});
  @override
  Widget build(BuildContext context) {
    if (isStarred) {
      return const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 24,
      );
    }
    return const SizedBox(width: 0, height: 0);
  }
}
