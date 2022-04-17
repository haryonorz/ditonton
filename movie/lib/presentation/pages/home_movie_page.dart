import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/presentation/cubit/now_playing_movies/now_playing_movies_state.dart';
import 'package:movie/presentation/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:movie/presentation/cubit/popular_movies/popular_movies_state.dart';
import 'package:movie/presentation/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/presentation/cubit/top_rated_movies/top_rated_movies_state.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

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
        title: const Text(APP_NAME),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchRoute);
            },
            icon: const Icon(Icons.search),
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesEmpty) {
                    return Container(
                      key: const Key('empty'),
                      child: const ViewError(message: 'No Data'),
                    );
                  } else if (state is NowPlayingMoviesHasData) {
                    return MovieList(state.movies);
                  } else if (state is NowPlayingMoviesError) {
                    return Container(
                      key: const Key('error_message'),
                      child: const ViewError(message: 'Failed'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: HEADING_POPULAR,
                onTap: () => Navigator.pushNamed(context, popularMovieRoute),
              ),
              BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesEmpty) {
                    return Container(
                      key: const Key('empty'),
                      child: const ViewError(message: 'No Data'),
                    );
                  } else if (state is PopularMoviesHasData) {
                    return MovieList(state.movies);
                  } else if (state is PopularMoviesError) {
                    return Container(
                      key: const Key('error_message'),
                      child: const ViewError(message: 'Failed'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: HEADING_TOP_RATED,
                onTap: () => Navigator.pushNamed(context, topRatedMovieRoute),
              ),
              BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesEmpty) {
                    return Container(
                      key: const Key('empty'),
                      child: const ViewError(message: 'No Data'),
                    );
                  } else if (state is TopRatedMoviesHasData) {
                    return MovieList(state.movies);
                  } else if (state is TopRatedMoviesError) {
                    return Container(
                      key: const Key('error_message'),
                      child: const ViewError(message: 'Failed'),
                    );
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

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                movieDetailRoute,
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
