import 'movie_list.dart';

class MovieData {
  int page;
  int totalResults;
  int totalPages;
  List<MovieList> movieList = [];

  MovieData({
    this.page,
    this.totalResults,
    this.totalPages,
    this.movieList,
  });

  static MovieData movieData(Map<String, dynamic> json) {
    return MovieData(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      movieList: MovieList.movieList(json),
    );
  }
}
