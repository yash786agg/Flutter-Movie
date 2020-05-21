import 'package:flutter/material.dart';
import 'package:flutter_movie/domain/model/movie_list.dart';
import 'package:flutter_movie/datasource/remote/api_client.dart';
import 'package:http/http.dart' as http;

class MovieDetailScreen extends StatefulWidget {
  final MovieList movieList;

  MovieDetailScreen({@required this.movieList}) : assert(movieList != null);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Movie Detail'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 16.0,
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Movie Id: ${widget.movieList.movieId}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Title: ${widget.movieList.title}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Overview: ${widget.movieList.overview}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Vote: ${widget.movieList.vote}',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
