import 'package:flutter/material.dart';

import '../users_bloc.dart';

class UserError extends UserState {
  final String errmsg; // error message
  const UserError({@required this.errmsg});

  @override
  List<Object> get props => [errmsg];
}
