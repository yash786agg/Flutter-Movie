import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_bloc_provider.dart';
import 'package:flutter_movie/domain/model/movie_list.dart';
import 'package:flutter_movie/domain/repository/movie_repository.dart';
import 'package:flutter_movie/screens/movie_detail_screen.dart';
import 'package:flutter_movie/util/contants.dart';

class MovieListWidget extends StatelessWidget {
  MovieListWidget({Key key, @required this.movieList})
      : assert(movieList != null),
        super(key: key);

  final MovieList movieList;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                //return MovieDetailScreen(movieList: movieList);
                return MovieTrailerBlocProvider(
                  child: MovieDetailScreen(movieList: movieList),
                );
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage(Constant.placeHolderImgPath),
                image: NetworkImage(
                  '${Constant.imageAppendUrl}${movieList.posterImg}',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                movieList.title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
