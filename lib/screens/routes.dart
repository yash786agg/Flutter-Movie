import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/screens/movie_detail_screen.dart';
import 'movie_list_screen.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/movieList': (context) => MovieListScreen(),
    '/movieDetail': (context) => MovieDetailScreen(),
  };
}
