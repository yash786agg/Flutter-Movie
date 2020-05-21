import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/domain/model/movie_data.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie/util/contants.dart';
import 'http_exception.dart';

class MovieApiClient {
  MovieApiClient({this.httpClient}) : assert(httpClient != null);

  final http.Client httpClient;

  Future<MovieData> fetchPopularMovieAsync({@required int page}) async {
    String requestUrl =
        '${Constant.baseUrl}${Constant.popularRequestTag}${Constant.apiKeyRequestTag}'
        '${Constant.theMovieBbApiKey}${Constant.languageRequestTag}'
        '${Constant.pageRequestTag}$page';

    print('MovieApiClient fetchPopularMovie requestUrl: $requestUrl');

    final response = await this.httpClient.get(requestUrl);
    if (response.statusCode != 200)
      throw HTTPException(
          code: response.statusCode,
          message: "Unable to fetch PopularMovie Data");

    final movieJson = json.decode(response.body);

    return MovieData.movieData(movieJson);
  }

  Future<List<MovieTrailer>> fetchMovieTrailerAsync(
      {@required int movieId}) async {
    // Reference Link: https://api.themoviedb.org/3/movie/419704/videos?api_key=<api_key>&language=en-US
    String requestUrl =
        '${Constant.baseUrl}$movieId${Constant.videosRequestTag}'
        '${Constant.apiKeyRequestTag}${Constant.theMovieBbApiKey}'
        '${Constant.languageRequestTag}';

    print('MovieApiClient fetchMovieTrailer requestUrl: $requestUrl');

    final response = await this.httpClient.get(requestUrl);
    if (response.statusCode != 200)
      throw HTTPException(
          code: response.statusCode,
          message: "Unable to fetch MovieTrailer Data");

    final trailerJson = json.decode(response.body);

    print('MovieApiClient fetchMovieTrailer trailerJson: $trailerJson');

    return MovieTrailer.movieTrailer(trailerJson);
  }
}
