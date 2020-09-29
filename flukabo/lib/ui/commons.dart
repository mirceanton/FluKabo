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
