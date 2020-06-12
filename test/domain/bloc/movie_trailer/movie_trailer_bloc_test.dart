import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_event.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../model/movie_trailer_data_builder.dart';

void main() {
  group('Movie Trailer Bloc', () {
    MovieTrailerBloc _movieTrailerBloc;

    setUp(() async {
      _movieTrailerBloc = MovieTrailerBloc();
    });

    tearDown(() async {
      _movieTrailerBloc.close();
    });

    List<MovieTrailer> movieTrailerSuccessData =
        MovieTrailerDataBuilder().successBuild();

    test("Movie Trailer Bloc testing", () async {
      _movieTrailerBloc.movieRepository.fetchMovieTrailer(movieId: 123);
      _movieTrailerBloc
          .mapEventToState(FetchMovieTrailer(movieId: 123))
          .listen(expectAsync1((_) {
        expect(movieTrailerSuccessData, isInstanceOf<List<MovieTrailer>>());
      }));
    });
  });
}
