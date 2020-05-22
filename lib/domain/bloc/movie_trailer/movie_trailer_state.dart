import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';

class MovieTrailerState extends Equatable {
  const MovieTrailerState();

  @override
  List<Object> get props => [];
}

class MovieTrailerLoading extends MovieTrailerState {}

class MovieTrailerSuccess extends MovieTrailerState {
  final List<MovieTrailer> movieTrailerList;

  const MovieTrailerSuccess({@required this.movieTrailerList})
      : assert(movieTrailerList != null);

  @override
  List<Object> get props => [movieTrailerList];

  @override
  String toString() =>
      'MovieTrailerSuccess { movieTrailerList: ${movieTrailerList.length} }';
}

class MovieTrailerError extends MovieTrailerState {
  final int errorCode;

  const MovieTrailerError({this.errorCode});

  @override
  List<Object> get props => [errorCode];
}
