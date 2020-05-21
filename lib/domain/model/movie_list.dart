class MovieList {
  int movieId;
  String posterImg;
  String title;
  var vote;
  String overview;
  String releaseDate;

  MovieList({
    this.movieId,
    this.posterImg,
    this.title,
    this.vote,
    this.overview,
    this.releaseDate,
  });

  static List<MovieList> movieList(Map<String, dynamic> json) {
    final jsonArray = json['results'];
    final list = List<MovieList>();
    for (final item in jsonArray) {
      MovieList movieList = MovieList();
      movieList.movieId = item['id'];
      movieList.posterImg = item['poster_path'];
      movieList.title = item['title'];
      movieList.vote = item['vote_average'];
      movieList.overview = item['overview'];
      movieList.releaseDate = item['release_date'];
      list.add(movieList);
    }
    return list;
  }
}
