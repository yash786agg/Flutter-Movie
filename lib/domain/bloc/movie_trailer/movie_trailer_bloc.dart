import 'package:bloc/bloc.dart';
import 'package:flutter_movie/datasource/remote/api_client.dart';
import 'package:flutter_movie/datasource/remote/http_exception.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_event.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_state.dart';
import 'package:flutter_movie/domain/repository/movie_repository.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';

class MovieTrailerBloc extends Bloc<MovieTrailerEvent, MovieTrailerState> {
  final MovieRepository movieRepository =
      MovieRepository(movieApiClient: MovieApiClient());

  @override
  MovieTrailerState get initialState => MovieTrailerLoading();

  @override
  Stream<MovieTrailerState> mapEventToState(MovieTrailerEvent event) async* {
    if (event is FetchMovieTrailer) {
      yield MovieTrailerLoading();

      try {
        final List<MovieTrailer> movieTrailerList =
            await movieRepository.fetchMovieTrailer(movieId: event.movieId);

        yield MovieTrailerSuccess(movieTrailerList: movieTrailerList);
      } catch (exception) {
        print('MovieTrailerBloc mapEventToState exception: $exception');
        if (exception is HTTPException) {
          yield MovieTrailerError(errorCode: exception.code);
        }
      }
    }
  }
}
