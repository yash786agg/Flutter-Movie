import 'package:flutter_movie/domain/model/movie_trailer.dart';

class MovieTrailerDataBuilder {
  List<MovieTrailer> successBuild() {
    List<MovieTrailer> movieTrailerList = List();
    movieTrailerList.add(
      MovieTrailer(
        trailerKey: '6WcJbPlAknw',
        trailerName: 'Lord of the Rings [1978] - One to Rule Them All',
        trailerSite: 'YouTube',
        trailerSize: 360,
      ),
    );
    movieTrailerList.add(
      MovieTrailer(
        trailerKey: 'qnIhJwhBeqY',
        trailerName: 'The Lord Of The Rings (1978) Trailer',
        trailerSite: 'YouTube',
        trailerSize: 480,
      ),
    );

    return movieTrailerList;
  }

  List<MovieTrailer> emptyBuild() {
    List<MovieTrailer> movieTrailerList = List();
    movieTrailerList.add(MovieTrailer());
    return movieTrailerList;
  }
}
