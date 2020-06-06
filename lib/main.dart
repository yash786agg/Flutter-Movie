import 'package:flutter/material.dart';
import 'package:flutter_movie/screens/movie_list_screen.dart';
import 'package:flutter_movie/screens/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_movie/widgets/app_state_container.dart';
import 'domain/bloc/simple_bloc_delegate.dart';

//void main() => runApp(MovieApp());

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(AppStateContainer(child: MovieApp()));
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie App',
      theme: AppStateContainer.of(context).theme,
      home: MovieListScreen(),
      routes: Routes.mainRoute,
    );
  }
}
