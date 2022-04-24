import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_cubit.dart';
import 'package:tv_show/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_state.dart';
import 'package:tv_show/presentation/cubit/popular_tv_shows/popular_tv_shows_cubit.dart';
import 'package:tv_show/presentation/cubit/popular_tv_shows/popular_tv_shows_state.dart';
import 'package:tv_show/presentation/cubit/top_rated_tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:tv_show/presentation/cubit/top_rated_tv_shows/top_rated_tv_shows_state.dart';

class HomeTvShowPage extends StatefulWidget {
  const HomeTvShowPage({Key? key}) : super(key: key);

  @override
  _HomeTvShowPageState createState() => _HomeTvShowPageState();
}

class _HomeTvShowPageState extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvShowsCubit>().fetchData();
      context.read<PopularTvShowsCubit>().fetchData();
      context.read<TopRatedTvShowsCubit>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
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
                headingNowPlaying,
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingTvShowsCubit, NowPlayingTvShowsState>(
                builder: (context, state) {
                  if (state is NowPlayingTvShowsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvShowsEmpty) {
                    return Container(
                      key: const Key('empty'),
                      child: const ViewError(message: 'No Data'),
                    );
                  } else if (state is NowPlayingTvShowsHasData) {
                    return TvShowList(state.tvShows);
                  } else if (state is NowPlayingTvShowsError) {
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
                title: headingPopular,
                onTap: () => Navigator.pushNamed(context, popularTvShowRoute),
              ),
              BlocBuilder<PopularTvShowsCubit, PopularTvShowsState>(
                builder: (context, state) {
                  if (state is PopularTvShowsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvShowsEmpty) {
                    return Container(
                      key: const Key('empty'),
                      child: const ViewError(message: 'No Data'),
                    );
                  } else if (state is PopularTvShowsHasData) {
                    return TvShowList(state.tvShows);
                  } else if (state is PopularTvShowsError) {
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
                title: headingTopRated,
                onTap: () => Navigator.pushNamed(context, topRatedTvShowRoute),
              ),
              BlocBuilder<TopRatedTvShowsCubit, TopRatedTvShowsState>(
                builder: (context, state) {
                  if (state is TopRatedTvShowsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvShowsEmpty) {
                    return Container(
                      key: const Key('empty'),
                      child: const ViewError(message: 'No Data'),
                    );
                  } else if (state is TopRatedTvShowsHasData) {
                    return TvShowList(state.tvShows);
                  } else if (state is TopRatedTvShowsError) {
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

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  const TvShowList(this.tvShows, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return PosterCard(
            posterPath: tvShow.posterPath,
            onTap: () {
              Navigator.pushNamed(
                context,
                tvShowDetailRoute,
                arguments: tvShow.id,
              );
            },
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
