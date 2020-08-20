part of 'theme_bloc.dart';

///
/// Here should be, in theory, an abstract base class from which we extend all
/// possible events handled by this bloc.
///
/// Since we only have 2 themes (dark/light), we can only switch between them
/// so we don't need more than 1 event
///
class ThemeSwitchEvent extends Equatable {
  const ThemeSwitchEvent();

  @override
  List<Object> get props => [];
}
