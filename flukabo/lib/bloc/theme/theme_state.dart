part of 'theme_bloc.dart';

///
/// Similarly to the event, we do not need an abstract state class from which
/// to extend various states, as this bloc only has one state
///
class ThemeState extends Equatable {
  final ThemeData themeData;
  const ThemeState({@required this.themeData});

  @override
  List<Object> get props => [themeData];
}
