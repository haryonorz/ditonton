import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:movie/presentation/cubit/movie_detail/movie_detail_state.dart';
import 'package:movie/presentation/cubit/movie_recommendations/movie_recommendations_cubit.dart';
import 'package:movie/presentation/cubit/movie_recommendations/movie_recommendations_state.dart';
import 'package:movie/presentation/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:movie/presentation/cubit/watchlist_movie/watchlist_movie_state.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailCubit>().fetchData(widget.id);
      context.read<WatchlistMovieCubit>().loadWatchlistStatus(widget.id);
      context.read<MovieRecommendationsCubit>().fetchData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistMovieCubit, WatchlistMovieState>(
      listener: (context, state) {
        if (state is WatchlistMovieMessage) {
          if (state.message == watchlistAddSuccessMessage ||
              state.message == watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.message),
                );
              },
            );
          }
        }
      },
      child: Scaffold(
        body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieDetailHasData) {
              final movie = state.movie;
              return SafeArea(
                child: BlocBuilder<WatchlistMovieCubit, WatchlistMovieState>(
                  builder: (context, state) {
                    bool isAddedWatchlist = false;
                    if (state is MovieIsAddedToWatchlist) {
                      isAddedWatchlist = state.isAdded;
                    }

                    return DetailContent(movie, isAddedWatchlist);
                  },
                ),
              );
            } else if (state is MovieDetailError) {
              return ViewError(
                key: const Key('error_message'),
                message: state.message,
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

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;

  const DetailContent(this.movie, this.isAddedWatchlist, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  context.read<WatchlistMovieCubit>()
                                    ..addToWatchlist(movie)
                                    ..loadWatchlistStatus(movie.id);
                                } else {
                                  context.read<WatchlistMovieCubit>()
                                    ..removeFromWatchlist(movie)
                                    ..loadWatchlistStatus(movie.id);
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              getFormattedGenre(movie.genres),
                            ),
                            Text(
                              getFormattedDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieRecommendationsCubit,
                                MovieRecommendationsState>(
                              builder: (context, state) {
                                if (state is MovieRecommendationsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieRecommendationsError) {
                                  return Container(
                                    key: const Key('error_message'),
                                    child: ViewError(message: state.message),
                                  );
                                } else if (state is MovieRecommendationsEmpty) {
                                  return Container(
                                    key: const Key('empty'),
                                    child: const ViewError(message: 'No Data'),
                                  );
                                } else if (state
                                    is MovieRecommendationsHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.movies[index];
                                        return Padding(
                                          key: const Key('recommendation_item'),
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                movieDetailRoute,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.movies.length,
                                    ),
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
