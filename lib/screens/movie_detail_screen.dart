import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_bloc_provider.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_event.dart';
import 'package:flutter_movie/domain/bloc/movie_trailer/movie_trailer_state.dart';
import 'package:flutter_movie/domain/model/movie_list.dart';
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
                    print(
                        'movieTrailerList length: ${state.movieTrailerList.length}');
                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        MovieDetailAppBar(
                          movieList: widget.movieList,
                          isShrink: isShrink,
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          // In this example, the inner scroll view has
                          // fixed-height list items, hence the use of
                          // SliverFixedExtentList. However, one could use any
                          // sliver widget here, e.g. SliverList or SliverGrid.
                          sliver: SliverFillViewport(
                            // The items in this example are fixed to 48 pixels
                            // high. This matches the Material Design spec for
                            // ListTile widgets.
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              // This builder is called for each child.
                              // In this example, we just number each list item.
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
                                    ],
                                  ),
                                ),
                              );
                            }, childCount: 1
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
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

  @override
  void dispose() {
    _movieTrailerBloc.close();
    super.dispose();
  }
}
