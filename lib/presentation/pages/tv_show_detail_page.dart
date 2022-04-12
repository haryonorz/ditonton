import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/formatter.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/presentation/cubit/tv_show_detail/tv_show_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_show_detail/tv_show_detail_state.dart';
import 'package:ditonton/presentation/cubit/tv_show_recommendations/tv_show_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_show_recommendations/tv_show_recommendations_state.dart';
import 'package:ditonton/presentation/cubit/watchlist_tv_show/watchlist_tv_show_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_tv_show/watchlist_tv_show_state.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show-detail';

  final int id;
  TvShowDetailPage({required this.id});

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
    return Scaffold(
      body: BlocBuilder<TvShowDetailCubit, TvShowDetailState>(
        builder: (context, state) {
          if (state is TvShowDetailLoading) {
            return Center(
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
              key: Key('error_message'),
              message: state.message,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvShowDetail tvShow;
  final bool isAddedWatchlist;

  DetailContent(this.tvShow, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                                  context
                                      .read<WatchlistTvShowCubit>()
                                      .addToWatchlist(tvShow);
                                } else {
                                  context
                                      .read<WatchlistTvShowCubit>()
                                      .removeFromWatchlist(tvShow);
                                }

                                final state = Provider.of<WatchlistTvShowCubit>(
                                        context,
                                        listen: false)
                                    .state;

                                if (state is TvShowIsAddedToWatchlist) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      state.isAdded
                                          ? watchlistRemoveSuccessMessage
                                          : watchlistAddSuccessMessage,
                                    ),
                                  ));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
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
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvShow.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvShow.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Total Episodes',
                              style: kHeading6,
                            ),
                            Text(
                              '${tvShow.numberOfEpisodes} Episode',
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Total Seasons',
                              style: kHeading6,
                            ),
                            Text(
                              '${tvShow.numberOfSeasons} Season',
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            SeasonList(seasons: tvShow.seasons),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvShowRecommendationsCubit,
                                TvShowRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvShowRecommendationsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is TvShowRecommendationsError) {
                                  return ViewError(message: state.message);
                                } else if (state
                                    is TvShowRecommendationsEmpty) {
                                  return ViewError(message: 'No Data');
                                } else if (state
                                    is TvShowRecommendationsHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvShow = state.tvShows[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvShowDetailPage.ROUTE_NAME,
                                                arguments: tvShow.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
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
              icon: Icon(Icons.arrow_back),
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
    return Container(
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
                          SizedBox(height: 4),
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
                              imageUrl: '$BASE_IMAGE_URL${season.posterPath}',
                              width: 80,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : Container(
                              color: kDavysGrey,
                              width: 80,
                              child: Center(child: Icon(Icons.image)),
                            ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
