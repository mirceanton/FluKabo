import 'package:flutter/material.dart';

import '../users_bloc.dart';

class ErrorState extends UserState {
  final int errno; // error number
  final String errmsg; // error message
  const ErrorState({
    this.errno,
    @required this.errmsg,
  });

  @override
  List<Object> get props => [errno, errmsg];
}
