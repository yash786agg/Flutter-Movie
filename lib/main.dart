import 'package:flutter/material.dart';
import 'package:flutter_movie/screens/movie_list_screen.dart';
import 'package:flutter_movie/screens/routes.dart';

void main() => runApp(MovieApp());

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie App',
      home: MovieListScreen(),
      routes: Routes.mainRoute,
    );
  }
}
