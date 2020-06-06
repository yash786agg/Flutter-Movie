import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_event.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_state.dart';
import 'package:flutter_movie/screens/settings_screen.dart';
import 'package:flutter_movie/widgets/app_state_container.dart';
import 'package:flutter_movie/widgets/bottom_loading_indicator.dart';
import 'package:flutter_movie/widgets/movie_list_widget.dart';
import 'package:flutter_movie/widgets/popup_menu_options.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  MovieListBloc _movieListBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    print('initState MovieListScreen');

    _movieListBloc = MovieListBloc()..add(FetchMovieList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: TextStyle(
            color: AppStateContainer.of(context).theme.accentColor,
          ),
        ),
        backgroundColor: AppStateContainer.of(context).theme.primaryColor,
        centerTitle: true,
        elevation: 50.0,
        actions: [
          PopUpMenuOptions(
            onSelected: (OptionsMenu result) {
              switch (result) {
                case OptionsMenu.settings:
                  print('PopUpMenuOptions settings clicked!!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SettingScreen();
                      },
                    ),
                  );
                  break;
              }
            },
          ),
        ],
      ),
      backgroundColor: AppStateContainer.of(context).theme.accentColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: new OrientationBuilder(builder: (context, orientation) {
          return BlocBuilder(
              bloc: _movieListBloc,
              // ignore: missing_return
              builder: (context, state) {
                if (state is MovieListLoading) {
                  return Center(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        accentColor:
                            AppStateContainer.of(context).theme.primaryColor,
                      ),
                      child: new CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is MovieListSuccess) {
                  if (state.movieList.isNotEmpty) {
                    return CustomScrollView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      slivers: [
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return MovieListWidget(
                                  movieList: state.movieList[index]);
                            },
                            childCount: state.movieList.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                orientation == Orientation.portrait ? 2 : 3,
                            childAspectRatio: 0.55,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: BottomLoadingIndicator(),
                        )
                      ],
                    );
                  }
                }
                if (state is MovieListError) {
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
    _scrollController.dispose();
    _movieListBloc.close();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _movieListBloc.add(FetchMovieList());
    }
  }
}
