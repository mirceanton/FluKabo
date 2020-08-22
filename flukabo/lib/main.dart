import 'package:flukabo/bloc/auth/auth_bloc.dart';
import 'package:flukabo/res/app_themes.dart';
import 'package:flukabo/data/singletons/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/theme/theme.dart';
import 'ui/pages/home/home.dart';
import 'ui/pages/search/search.dart';
import 'ui/pages/settings/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();

  runApp(const FlukaboApp());
}

class FlukaboApp extends StatelessWidget {
  const FlukaboApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(
            UserPreferences().isDarkTheme ? AppTheme.Dark : AppTheme.Light,
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      title: 'Flukabo',
      theme: state.themeData,
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/settings/server': (context) => ServerSettingsPage(),
        '/settings/appearance': (context) => AppearanceSettingsPage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
