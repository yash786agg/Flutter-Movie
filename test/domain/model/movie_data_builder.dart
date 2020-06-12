import 'package:flutter_movie/domain/model/movie_data.dart';
import 'package:flutter_movie/domain/model/movie_list.dart';

class MovieDataBuilder {
  MovieData successBuild() {
    String overView = 'The near future, a time when both hope and hardships '
        'drive humanity to look to the stars and beyond. While a mysterious '
        'phenomenon menaces to destroy life on planet Earth, astronaut Roy '
        'McBride undertakes a mission across the immensity of space and its '
        'many perils to uncover the truth about a lost expedition that decades '
        'before boldly faced emptiness and silence in search of the unknown.';
    List<MovieList> movieList = List();
    movieList.add(
      MovieList(
        releaseDate: '2019-09-17',
        overview: overView,
        vote: 6,
        title: 'Ad Astra',
        posterImg: '/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg',
        movieId: 419704,
      ),
    );
    return MovieData(
      page: 1,
      totalPages: 500,
      totalResults: 10000,
      movieList: movieList,
    );
  }

  MovieData emptyBuild() {
    List<MovieList> movieList = List();
    movieList.add(
      MovieList(),
    );
    return MovieData(
      movieList: movieList,
    );
  }
}
