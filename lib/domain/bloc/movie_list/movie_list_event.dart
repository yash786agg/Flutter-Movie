import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMovieList extends MovieListEvent {}
