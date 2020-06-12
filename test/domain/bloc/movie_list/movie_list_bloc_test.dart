import 'package:flutter_movie/domain/bloc/movie_list/movie_list_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_event.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_state.dart';
import 'package:flutter_movie/domain/model/movie_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../model/movie_data_builder.dart';
import '../../repository/mock_movie_repository.dart';

/*
* Reference Link:- https://blog.codemagic.io/flutter-unit-testing-bloc-with-codemagic/
* https://resocoder.com/2019/11/29/bloc-test-tutorial-easier-way-to-test-blocs-in-dart-flutter/
* https://blog.usejournal.com/integration-and-unit-testing-in-flutter-f08e4bd961d5
* https://medium.com/flutter-community/unit-testing-with-bloc-b94de9655d86
*/

void main() {
  group('Movie List Bloc', () {
    MockMovieRepository _mockMovieRepository;
    MovieListBloc movieListBloc;
    setUp(() async {
      _mockMovieRepository = MockMovieRepository();
      movieListBloc = MovieListBloc(movieRepository: _mockMovieRepository);
    });

    tearDown(() async {
      movieListBloc.close();
    });

    MovieData movieSuccessData = MovieDataBuilder().successBuild();

    test('Loading state is correct', () {
      expect(movieListBloc.initialState, MovieListLoading());
    });

    test('close does not emit new states', () {
      expectLater(
        movieListBloc,
        emitsInOrder([MovieListLoading(), emitsDone]),
      );
      movieListBloc.close();
    });

    test('throws AssertionError if MovieRepository is null', () {
      expect(
        () => MovieListBloc(movieRepository: null),
        throwsA(isAssertionError),
      );
    });

    test(
      'emits [MovieListLoading, MovieListSuccess] when successful',
      () {
        when(_mockMovieRepository.fetchPopularMovie(page: 1))
            .thenAnswer((_) async => movieSuccessData);
        final bloc = movieListBloc;
        bloc.add(FetchMovieList());
        expectLater(
          bloc,
          emitsInOrder([
            MovieListLoading(),
            MovieListSuccess(
              movieList: movieSuccessData.movieList,
              hasReachedMax: false,
            ),
          ]),
        );
      },
    );
  });
}
