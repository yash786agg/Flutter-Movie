import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MovieTrailerEvent extends Equatable {
  const MovieTrailerEvent();
}

class FetchMovieTrailer extends MovieTrailerEvent {
  final int movieId;

  const FetchMovieTrailer({@required this.movieId}) : assert(movieId != null);

  @override
  List<Object> get props => [movieId];
}
