import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/datasource/remote/http_provider.dart';
import 'package:flutter_movie/domain/model/movie_data.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';
import 'package:flutter_movie/util/contants.dart';

class MovieApiClient {
  HTTPProvider _httpProvider = HTTPProvider();

  Future<MovieData> fetchPopularMovieAsync({@required int page}) async {
    // Reference Link:- http://api.themoviedb.org/3/movie/popular?api_key=<api_key>&language=en-US&page=1
    String requestUrl =
        '${Constant.popularRequestTag}${Constant.apiKeyRequestTag}'
        '${Constant.theMovieBbApiKey}${Constant.languageRequestTag}'
        '${Constant.pageRequestTag}$page';

    final movieJson = await _httpProvider.get(requestUrl);

    print('MovieApiClient fetchPopularMovieAsync movieJson: $movieJson');

    return MovieData.movieData(movieJson);
  }

  Future<List<MovieTrailer>> fetchMovieTrailerAsync(
      {@required int movieId}) async {
    // Reference Link: https://api.themoviedb.org/3/movie/419704/videos?api_key=<api_key>&language=en-US
    String requestUrl = '$movieId${Constant.videosRequestTag}'
        '${Constant.apiKeyRequestTag}${Constant.theMovieBbApiKey}'
        '${Constant.languageRequestTag}';

    final trailerJson = await _httpProvider.get(requestUrl);

    print('MovieApiClient fetchMovieTrailer trailerJson: $trailerJson');

    return MovieTrailer.movieTrailer(trailerJson);
  }
}
