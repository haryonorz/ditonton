import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/presentation/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_movies/popular_movies_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PopularMoviesCubit>().fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$HEADING_POPULAR Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesEmpty) {
              return Center(
                child: ViewError(message: 'No Data'),
              );
            } else if (state is PopularMoviesHasData) {
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
            } else if (state is PopularMoviesError) {
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
