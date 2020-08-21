import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'abstract_tab_class.dart';

class AccountTab extends HomeTab {
  const AccountTab();

  @override
  String getName() => 'Account';
  @override
  IconData getIcon() => MdiIcons.account;

  @override
  Future<void> refresh() async {
    //TODO
  }

  // TODO
  @override
  Widget buildSelf() => Center(child: Text(getName()));
}
