import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/datasource/remote/api_client.dart';
import 'package:flutter_movie/domain/model/movie_data.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';

class MovieRepository {
  MovieRepository({@required this.movieApiClient})
      : assert(movieApiClient != null);

  final MovieApiClient movieApiClient;

  Future<MovieData> fetchPopularMovie({@required int page}) async {
    MovieData response =
        await this.movieApiClient.fetchPopularMovieAsync(page: page);

    print('Response PopularMovie length: ${response.movieList.length}');
    print('Response PopularMovie Title: ${response.movieList[0].title}');
    return response;
  }

  Future<List<MovieTrailer>> fetchMovieTrailer({@required int movieId}) async {
    List<MovieTrailer> response =
        await this.movieApiClient.fetchMovieTrailerAsync(movieId: movieId);

    print('Response MovieTrailer length: ${response.length}');
    print('Response MovieTrailer Title: ${response[0].trailerKey}');

    return response;
  }
}
