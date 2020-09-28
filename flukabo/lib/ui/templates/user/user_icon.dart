import 'package:flukabo/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserIcon extends StatelessWidget {
  final UserModel user;
  const UserIcon({this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const SizedBox();
    } else {
      final String init = user.name.isEmpty ? user.username[0] : user.name[0];

      return Stack(
        alignment: Alignment.center,
        children: [
          const Icon(MdiIcons.circle, size: 32),
          Text(
            init.toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ],
      );
    }
  }
}
