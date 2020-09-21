import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'abstract_tab_class.dart';

class AccountTab extends HomeTab {
  AccountTab();

  @override
  String get name => 'Account';
  @override
  IconData get icon => MdiIcons.account;

  @override
  HomeTabState createState() => _AccountTabState();
}

class _AccountTabState extends HomeTabState {}
