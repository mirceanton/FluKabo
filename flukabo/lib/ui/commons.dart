import 'package:flutter/material.dart';

///
/// [showSnackbar] is self explanatory. It will display the given [content]
/// in a custom snackbar
///
void showSnackbar({
  @required BuildContext context,
  @required String content,
}) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

class DynamicButton extends StatelessWidget {
  final IconData icon;
  final double angle;
  final double size;
  final void Function(BuildContext) onPressed;

  const DynamicButton({
    @required this.icon,
    @required this.angle,
    @required this.size,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: IconButton(
        icon: Icon(icon, size: size),
        onPressed: () => onPressed(context),
      ),
    );
  }
}

class DynamicHeroButton extends StatelessWidget {
  final IconData icon;
  final double angle;
  final double size;
  final void Function(BuildContext) onPressed;
  final String tag;

  const DynamicHeroButton({
    @required this.angle,
    @required this.icon,
    @required this.onPressed,
    @required this.size,
    @required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: DynamicButton(
          icon: icon,
          angle: angle,
          size: size,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

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
