import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_movie/datasource/remote/http_exception.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_event.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_state.dart';
import 'package:flutter_movie/domain/repository/movie_repository.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  /*final MovieRepository _movieRepository =
      MovieRepository(movieApiClient: MovieApiClient());*/

  final MovieRepository movieRepository;
  MovieListBloc({this.movieRepository}) : assert(movieRepository != null);

  int pageValue = 1;

  @override
  MovieListState get initialState => MovieListLoading();

  @override
  Stream<Transition<MovieListEvent, MovieListState>> transformEvents(
      Stream<MovieListEvent> events, transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    final currentState = state;
    if (event is FetchMovieList && !_hasReachedMax(currentState)) {
      try {
        if (currentState is MovieListLoading) {
          print(
              'MovieListBloc mapEventToState MovieListLoading pageValue: $pageValue');
          final movieData =
              await movieRepository.fetchPopularMovie(page: pageValue);
          _updatePageValue(movieData.page);
          yield MovieListSuccess(
              movieList: movieData.movieList, hasReachedMax: false);
          return;
        }
        if (currentState is MovieListSuccess) {
          print(
              'MovieListBloc mapEventToState MovieListSuccess pageValue: $pageValue');
          final movieData =
              await movieRepository.fetchPopularMovie(page: pageValue);
          yield movieData.totalPages == pageValue
              ? currentState.copyWith(hasReachedMax: true)
              : MovieListSuccess(
                  movieList: currentState.movieList + movieData.movieList,
                  hasReachedMax: false,
                );
          _updatePageValue(movieData.page);
        }
      } catch (exception) {
        print('MovieListBloc mapEventToState exception: $exception');
        if (exception is HTTPException) {
          yield MovieListError(errorCode: exception.code);
        }
      }
    }
  }

  void _updatePageValue(int page) {
    if (page >= 1) pageValue = page + 1;
  }

  bool _hasReachedMax(MovieListState state) =>
      state is MovieListSuccess && state.hasReachedMax;
}
