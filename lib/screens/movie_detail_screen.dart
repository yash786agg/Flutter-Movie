import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_bloc_provider.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_event.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_state.dart';
import 'package:flutter_movie/domain/model/movie_list.dart';
import 'package:flutter_movie/domain/model/movie_trailer.dart';
import 'package:flutter_movie/util/contants.dart';
import 'package:flutter_movie/widgets/app_launcher.dart';
import 'package:flutter_movie/widgets/movie_detail_app_bar.dart';
import 'package:flutter_movie/widgets/movie_detail_description.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieList movieList;
  MovieDetailScreen({this.movieList}) : assert(movieList != null);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieTrailerBloc _movieTrailerBloc;
  ScrollController _scrollController;

  bool lastStatus = true;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void didChangeDependencies() {
    _movieTrailerBloc = MovieTrailerBlocProvider.of(context)
      ..add(FetchMovieTrailer(movieId: widget.movieList.movieId));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  // Link:- https://flutter-widget.live/widgets/NestedScrollView
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: OrientationBuilder(builder: (context, orientation) {
          return BlocBuilder(
              bloc: _movieTrailerBloc,
              // ignore: missing_return
              builder: (context, state) {
                if (state is MovieTrailerLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is MovieTrailerSuccess) {
                  if (state.movieTrailerList.isNotEmpty) {
                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        MovieDetailAppBar(
                          movieList: widget.movieList,
                          isShrink: isShrink,
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverFillViewport(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MovieDetailDescription(
                                          movieList: widget.movieList,
                                        ),
                                        trailerLayout(state.movieTrailerList)
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
                if (state is MovieTrailerError) {
                  return Center(
                    child: Text('failed to fetch response: ${state.errorCode}'),
                  );
                }
              });
        }),
      ),
    );
  }

  Widget noTrailer(MovieTrailer data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(List<MovieTrailer> trailerData) {
    return Container(
      height: 150.0,
      child: LayoutBuilder(builder: (context, constraint) {
        return new ListView.builder(
          itemCount: trailerData.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final items = trailerData[index];
            return InkWell(
              onTap: () {
                String url = '${Constant.youtubeBaseUrl}${items.trailerKey}';
                AppLauncher(url: url);
              },
              child: Container(
                width: 150.0,
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: 100.0,
                      color: Colors.black,
                      child: Center(
                        child: Icon(
                          Icons.play_circle_filled,
                          color: Colors.grey,
                          size: 48.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      items.trailerName,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    _movieTrailerBloc.close();
    super.dispose();
  }
}
