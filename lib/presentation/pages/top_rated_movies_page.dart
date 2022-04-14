import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/presentation/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_movies/top_rated_movies_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedMoviesCubit>().fetchData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$HEADING_TOP_RATED Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesEmpty) {
              return Center(
                key: Key('empty'),
                child: ViewError(message: 'No Data'),
              );
            } else if (state is TopRatedMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return ContentCard(
                    activeMenu: MenuItem.Movie,
                    movie: movie,
                    routeName: MovieDetailPage.ROUTE_NAME,
                  );
                },
                itemCount: state.movies.length,
              );
            } else if (state is TopRatedMoviesError) {
              return Center(
                key: Key('error_message'),
                child: ViewError(message: state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
