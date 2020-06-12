import 'package:flutter_movie/domain/model/movie_data.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../datasource/remote/mock_api_cilent.dart';
import '../model/movie_data_builder.dart';
import '../model/movie_trailer_data_builder.dart';

void main() {
  group('fetchMovie', () {
    MockAPIClient _mockAPIClient;

    setUp(() async {
      _mockAPIClient = MockAPIClient();
    });

    tearDown(() async {
      _mockAPIClient = null;
    });

    test('fetch Movie List then then map result correctly', () async {
      MovieData movieSuccessData = MovieDataBuilder().successBuild();
      when(_mockAPIClient.fetchPopularMovieAsync(page: 1))
          .thenAnswer((_) => Future.value(movieSuccessData));

      expect(await _mockAPIClient.fetchPopularMovieAsync(page: 1),
          TypeMatcher<MovieData>());
    });

    test('movie List empty', () async {
      MovieData movieEmptyData = MovieDataBuilder().emptyBuild();
      when(_mockAPIClient.fetchPopularMovieAsync(page: 1))
          .thenAnswer((_) => Future.value(movieEmptyData));

      expect(await _mockAPIClient.fetchPopularMovieAsync(page: 1),
          TypeMatcher<MovieData>());
    });

    test('fetch Movie Trailer then then map result correctly', () async {
      List<MovieTrailer> movieTrailerSuccessData =
          MovieTrailerDataBuilder().successBuild();
      when(_mockAPIClient.fetchMovieTrailerAsync(movieId: 1))
          .thenAnswer((_) => Future.value(movieTrailerSuccessData));

      expect(await _mockAPIClient.fetchMovieTrailerAsync(movieId: 1),
          TypeMatcher<List<MovieTrailer>>());
    });

    test('movie Trailer List empty', () async {
      List<MovieTrailer> movieTrailerEmptyData =
          MovieTrailerDataBuilder().emptyBuild();
      when(_mockAPIClient.fetchMovieTrailerAsync(movieId: 1))
          .thenAnswer((_) => Future.value(movieTrailerEmptyData));

      expect(await _mockAPIClient.fetchMovieTrailerAsync(movieId: 1),
          TypeMatcher<List<MovieTrailer>>());
    });
  });
}
