class MovieTrailer {
  String trailerKey;
  String trailerName;
  String trailerSite;
  int trailerSize;

  MovieTrailer({
    this.trailerKey,
    this.trailerName,
    this.trailerSite,
    this.trailerSize,
  });

  static List<MovieTrailer> movieTrailer(Map<String, dynamic> json) {
    final jsonArray = json['results'];
    final list = List<MovieTrailer>();
    for (final item in jsonArray) {
      MovieTrailer movieTrailer = MovieTrailer();
      movieTrailer.trailerKey = item['key'];
      movieTrailer.trailerName = item['name'];
      movieTrailer.trailerSite = item['site'];
      movieTrailer.trailerSize = item['size'];
      list.add(movieTrailer);
    }
    return list;
  }
}
