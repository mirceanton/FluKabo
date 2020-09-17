import 'package:flutter/material.dart';

import '../users_bloc.dart';

class ErrorState extends UserState {
  final String errmsg; // error message
  const ErrorState({@required this.errmsg});

  @override
  List<Object> get props => [errmsg];
}
