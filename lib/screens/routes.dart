import 'package:flutter/cupertino.dart';
import 'movie_list_screen.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/movieList': (context) => MovieListScreen(),
  };
}
