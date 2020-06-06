import 'package:flutter/material.dart';
import 'package:flutter_movie/util/contants.dart';
import 'package:flutter_movie/util/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;

  AppStateContainer({@required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppStateContainerProvider>()
        .appStateContainer;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
  ThemeData _theme = Themes.getTheme(Themes.LIGHT_THEME_CODE);
  int themeCode = Themes.DARK_THEME_CODE;

  ThemeData get theme => _theme;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((sharedPref) {
      setState(() {
        themeCode = sharedPref.getInt(Constant.SHARED_PREF_KEY_THEME) ??
            Themes.DARK_THEME_CODE;

        print('AppStateContainer themeCode initState: $themeCode');

        this._theme = Themes.getTheme(themeCode);
      });
    });
  }

  updateTheme(int themeCode) {
    setState(() {
      print('AppStateContainer themeCode updateTheme: $themeCode');
      _theme = Themes.getTheme(themeCode);
      this.themeCode = themeCode;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(Constant.SHARED_PREF_KEY_THEME, themeCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('AppStateContainer theme: ${theme.accentColor}');
    return AppStateContainerProvider(
      appStateContainer: this,
      child: widget.child,
    );
  }
}

class AppStateContainerProvider extends InheritedWidget {
  final _AppStateContainerState appStateContainer;

  AppStateContainerProvider(
      {Key key, @required this.appStateContainer, @required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
