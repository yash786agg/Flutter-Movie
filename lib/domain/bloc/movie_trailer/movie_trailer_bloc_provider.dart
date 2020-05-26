import 'package:flutter/material.dart';
import 'movie_trailer_bloc.dart';

class MovieTrailerBlocProvider extends InheritedWidget {
  final MovieTrailerBloc movieTrailerBloc;

  MovieTrailerBlocProvider({Key key, Widget child})
      : movieTrailerBloc = MovieTrailerBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MovieTrailerBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MovieTrailerBlocProvider)
            as MovieTrailerBlocProvider)
        .movieTrailerBloc;
  }
}
