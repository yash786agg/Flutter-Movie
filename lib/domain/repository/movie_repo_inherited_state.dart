import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/datasource/remote/api_client.dart';
import 'movie_repository.dart';

// Link:- https://ericwindmill.com/articles/inherited_widget/
// Link:- https://bloclibrary.dev/#/flutterweathertutorial
class _MovieRepoInheritedState extends InheritedWidget {
  // Data is your entire state. In our case just 'User'
  final MovieRepoStateContainerState data;

  // You must pass through a child and your state.
  _MovieRepoInheritedState({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class MovieRepoStateContainer extends StatefulWidget {
  // You must pass through a child.
  final Widget child;

  MovieRepoStateContainer({
    @required this.child,
  });

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static MovieRepoStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_MovieRepoInheritedState)
            as _MovieRepoInheritedState)
        .data;
  }

  @override
  MovieRepoStateContainerState createState() =>
      new MovieRepoStateContainerState();
}

class MovieRepoStateContainerState extends State<MovieRepoStateContainer> {
  MovieRepository _movieRepository =
      MovieRepository(movieApiClient: MovieApiClient());

  MovieRepository get movieRepository => _movieRepository;

  @override
  Widget build(BuildContext context) {
    return new _MovieRepoInheritedState(
      data: this,
      child: widget.child,
    );
  }
}
