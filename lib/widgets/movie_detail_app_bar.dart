import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/model/movie_list.dart';
import 'package:flutter_movie/util/contants.dart';

class MovieDetailAppBar extends StatelessWidget {
  final bool isShrink;
  final MovieList movieList;
  MovieDetailAppBar({this.movieList, this.isShrink})
      : assert(movieList != null);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 2.5;
    return SliverAppBar(
      expandedHeight: height,
      floating: true,
      pinned: true,
      snap: true,
      elevation: 50,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: isShrink ? Colors.black : Colors.white,
      ),
      title: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: isShrink ? 1.0 : 0.0,
        curve: Curves.ease,
        child: Text(movieList.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            softWrap: false,
            style: TextStyle(
              color: Colors.black,
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:
            const EdgeInsets.only(left: 20.0, bottom: 8.0, right: 8.0),
        centerTitle: false,
        collapseMode: CollapseMode.parallax,
        title: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: isShrink ? 0.0 : 1.0,
          curve: Curves.ease,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(
              movieList.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              softWrap: false,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ),
        ),
        background: FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage(Constant.placeHolderImgPath),
          image: NetworkImage(
            '${Constant.imageAppendUrl}${movieList.posterImg}',
          ),
        ),
      ),
    );
  }
}
