import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_movie/watchlist_movie_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistMovieCubit>().fetchData(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieCubit, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieEmpty) {
            return Center(
              child: ViewError(message: 'No Data'),
            );
          } else if (state is WatchlistMovieHasData) {
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
          } else if (state is WatchlistMovieError) {
            return Center(
              key: Key('error_message'),
              child: ViewError(message: state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
