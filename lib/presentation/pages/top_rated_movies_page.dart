import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedMoviesNotifier>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$HEADING_TOP_RATED Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return ContentCard(
                    activeMenu: MenuItem.Movie,
                    movie: movie,
                    routeName: MovieDetailPage.ROUTE_NAME,
                  );
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: ViewError(message: data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
