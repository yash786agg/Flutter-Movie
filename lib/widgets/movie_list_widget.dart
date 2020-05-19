import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/model/movie_list.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: FadeInImage(
              placeholder: AssetImage(Constant.placeHolderImgPath),
              image: NetworkImage(
                '${Constant.imageAppendUrl}${movieList.posterImg}',
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            movieList.title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
