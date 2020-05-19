import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/datasource/remote/api_client.dart';
import 'package:flutter_movie/domain/model/movie_data.dart';

class MovieRepository {
  MovieRepository({@required this.movieApiClient})
      : assert(movieApiClient != null);

  final MovieApiClient movieApiClient;

  Future<MovieData> fetchPopularMovie({@required int page}) async {
    MovieData response =
        await this.movieApiClient.fetchPopularMovieAsync(page: page);

    print('Response length: ${response.movieList.length}');
    print('Response vote: ${response.movieList[1].vote}');
    return response;
  }
}
