import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/datasource/remote/api_client.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_bloc.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_event.dart';
import 'package:flutter_movie/domain/bloc/movie_list/movie_list_state.dart';
import 'package:flutter_movie/domain/repository/movie_repository.dart';
import 'package:flutter_movie/widgets/bottom_loading_indicator.dart';
import 'package:flutter_movie/widgets/movie_list_widget.dart';
import 'package:http/http.dart' as http;

class MovieListScreen extends StatefulWidget {
  final MovieRepository movieRepository = MovieRepository(
      movieApiClient: MovieApiClient(httpClient: http.Client()));

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
    _movieListBloc = MovieListBloc(movieRepository: widget.movieRepository)
      ..add(FetchMovieList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 16.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: BlocBuilder(
            bloc: _movieListBloc,
            // ignore: missing_return
            builder: (context, state) {
              if (state is MovieListLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is MovieListSuccess) {
                if (state.movieList.isNotEmpty) {
                  return GridView.builder(
                    itemCount: state.hasReachedMax
                        ? state.movieList.length
                        : state.movieList.length + 1,
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.movieList.length
                          ? BottomLoadingIndicator()
                          : MovieListWidget(movieList: state.movieList[index]);
                    },
                  );
                }
              }
              if (state is MovieListError) {
                return Center(
                  child: Text('failed to fetch response: ${state.errorCode}'),
                );
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
