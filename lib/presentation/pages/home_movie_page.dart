import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/now_playing_movies/now_playing_movies_state.dart';
import 'package:ditonton/presentation/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_movies/popular_movies_state.dart';
import 'package:ditonton/presentation/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_movies/top_rated_movies_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/widgets/poster_card_list.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesCubit>().fetchData();
      context.read<PopularMoviesCubit>().fetchData();
      context.read<TopRatedMoviesCubit>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                HEADING_NOW_PLAYING,
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesHasData) {
                    return MovieList(state.movies);
                  } else if (state is NowPlayingMoviesError) {
                    return ViewError(message: 'Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: HEADING_POPULAR,
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasData) {
                    return MovieList(state.movies);
                  } else if (state is PopularMoviesError) {
                    return ViewError(message: 'Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: HEADING_TOP_RATED,
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesHasData) {
                    return MovieList(state.movies);
                  } else if (state is TopRatedMoviesError) {
                    return ViewError(message: 'Failed');
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return PosterCard(
            posterPath: movie.posterPath,
            onTap: () {
              Navigator.pushNamed(
                context,
                MovieDetailPage.ROUTE_NAME,
                arguments: movie.id,
              );
            },
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
