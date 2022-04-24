import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_show/domain/entities/season.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';
import 'package:tv_show/presentation/cubit/tv_show_detail/tv_show_detail_cubit.dart';
import 'package:tv_show/presentation/cubit/tv_show_detail/tv_show_detail_state.dart';
import 'package:tv_show/presentation/cubit/tv_show_recommendations/tv_show_recommendations_cubit.dart';
import 'package:tv_show/presentation/cubit/tv_show_recommendations/tv_show_recommendations_state.dart';
import 'package:tv_show/presentation/cubit/watchlist_tv_show/watchlist_tv_show_cubit.dart';
import 'package:tv_show/presentation/cubit/watchlist_tv_show/watchlist_tv_show_state.dart';

class TvShowDetailPage extends StatefulWidget {
  final int id;
  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvShowDetailPagePageState createState() => _TvShowDetailPagePageState();
}

class _TvShowDetailPagePageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvShowDetailCubit>().fetchData(widget.id);
      context.read<WatchlistTvShowCubit>().loadWatchlistStatus(widget.id);
      context.read<TvShowRecommendationsCubit>().fetchData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistTvShowCubit, WatchlistTvShowState>(
      listener: (context, state) {
        if (state is WatchlistTvShowMessage) {
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
        body: BlocBuilder<TvShowDetailCubit, TvShowDetailState>(
          builder: (context, state) {
            if (state is TvShowDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowDetailHasData) {
              final tvShow = state.tvShow;
              return SafeArea(
                child: BlocBuilder<WatchlistTvShowCubit, WatchlistTvShowState>(
                    builder: (context, state) {
                  bool isAddedWatchlist = false;
                  if (state is TvShowIsAddedToWatchlist) {
                    isAddedWatchlist = state.isAdded;
                  }
                  return DetailContent(tvShow, isAddedWatchlist);
                }),
              );
            } else if (state is TvShowDetailError) {
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
  final TvShowDetail tvShow;
  final bool isAddedWatchlist;

  const DetailContent(this.tvShow, this.isAddedWatchlist, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
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
                              tvShow.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  context.read<WatchlistTvShowCubit>()
                                    ..addToWatchlist(tvShow)
                                    ..loadWatchlistStatus(tvShow.id);
                                } else {
                                  context.read<WatchlistTvShowCubit>()
                                    ..removeFromWatchlist(tvShow)
                                    ..loadWatchlistStatus(tvShow.id);
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
                              getFormattedGenre(tvShow.genres),
                            ),
                            Text(
                              tvShow.episodeRunTime.isNotEmpty
                                  ? '[${getFormattedDurationFromList(tvShow.episodeRunTime)}]'
                                  : 'N/A',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvShow.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShow.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Total Episodes',
                              style: kHeading6,
                            ),
                            Text(
                              '${tvShow.numberOfEpisodes} Episode',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Total Seasons',
                              style: kHeading6,
                            ),
                            Text(
                              '${tvShow.numberOfSeasons} Season',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            SeasonList(seasons: tvShow.seasons),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvShowRecommendationsCubit,
                                TvShowRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvShowRecommendationsLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TvShowRecommendationsError) {
                                  return Container(
                                    key: const Key('error_message'),
                                    child: ViewError(message: state.message),
                                  );
                                } else if (state
                                    is TvShowRecommendationsEmpty) {
                                  return Container(
                                    key: const Key('empty'),
                                    child: const ViewError(message: 'No Data'),
                                  );
                                } else if (state
                                    is TvShowRecommendationsHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = state.tvShows[index];
                                        return Padding(
                                          key: const Key('recommendation_item'),
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                tvShowDetailRoute,
                                                arguments: tvShow.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
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
                                      itemCount: state.tvShows.length,
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

class SeasonList extends StatelessWidget {
  final List<Season> seasons;

  const SeasonList({
    required this.seasons,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final season = seasons[index];
          return Container(
            margin: const EdgeInsets.only(top: 4, bottom: 8),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Card(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 16 + 80 + 8,
                        top: 8,
                        right: 8,
                      ),
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${season.seasonNumber} Season',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kHeading6,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${season.airDate != null ? season.airDate?.substring(0, 4) : 'N/A'} | ${season.seasonNumber} Episode',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                    ),
                    child: ClipRRect(
                      child: season.posterPath != null
                          ? CachedNetworkImage(
                              imageUrl: '$baseImageURL${season.posterPath}',
                              width: 80,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Container(
                              color: kDavysGrey,
                              width: 80,
                              child: const Center(child: Icon(Icons.image)),
                            ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    )),
              ],
            ),
          );
        },
        itemCount: seasons.length,
      ),
    );
  }
}
