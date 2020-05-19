import 'package:equatable/equatable.dart';
import 'package:flutter_movie/domain/model/movie_list.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListLoading extends MovieListState {}

class MovieListSuccess extends MovieListState {
  final List<MovieList> movieList;
  final bool hasReachedMax;

  const MovieListSuccess({this.movieList, this.hasReachedMax});

  MovieListSuccess copyWith({
    List<MovieList> movieList,
    bool hasReachedMax,
  }) {
    return MovieListSuccess(
      movieList: movieList ?? this.movieList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [movieList, hasReachedMax];

  @override
  String toString() =>
      'MovieListSuccess { movieData: ${movieList.length}, hasReachedMax: $hasReachedMax }';
}

class MovieListError extends MovieListState {
  final int errorCode;

  const MovieListError({this.errorCode});

  @override
  List<Object> get props => [errorCode];
}
