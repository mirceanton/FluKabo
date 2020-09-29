import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../data/models/user.dart';

class UserIcon extends StatelessWidget {
  final UserModel user;
  const UserIcon(this.user);

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const SizedBox();
    } else {
      final String init = user.name.isEmpty ? user.username[0] : user.name[0];

      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            MdiIcons.circle,
            size: 40,
            color: Theme.of(context).accentColor,
          ),
          Text(
            init.toUpperCase(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      );
    }
  }
}
