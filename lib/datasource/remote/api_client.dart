import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/domain/model/movie_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie/util/contants.dart';
import 'http_exception.dart';

class MovieApiClient {
  MovieApiClient({this.httpClient}) : assert(httpClient != null);

  final http.Client httpClient;

  Future<MovieData> fetchPopularMovieAsync({@required int page}) async {
    String requestUrl =
        '${Constant.baseUrl}/popular?api_key=${Constant.theMovieBbApiKey}&language=en-US&page=$page';

    print('MovieApiClient requestUrl: $requestUrl');

    final response = await this.httpClient.get(requestUrl);
    if (response.statusCode != 200)
      throw HTTPException(
          code: response.statusCode, message: "Unable to fetch Weather Data");

    final movieJson = json.decode(response.body);

    return MovieData.movieData(movieJson);
  }
}
