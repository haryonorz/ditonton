import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_state.dart';
import 'package:ditonton/presentation/cubit/popular_tv_shows/popular_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_tv_shows/popular_tv_shows_state.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv_shows/top_rated_tv_shows_state.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/widgets/poster_card_list.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvShowPage extends StatefulWidget {
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
              BlocBuilder<NowPlayingTvShowsCubit, NowPlayingTvShowsState>(
                builder: (context, state) {
                  if (state is NowPlayingTvShowsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvShowsHasData) {
                    return TvShowList(state.tvShows);
                  } else if (state is NowPlayingTvShowsError) {
                    return ViewError(message: 'Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: HEADING_POPULAR,
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvShowsPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvShowsCubit, PopularTvShowsState>(
                builder: (context, state) {
                  if (state is PopularTvShowsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvShowsHasData) {
                    return TvShowList(state.tvShows);
                  } else if (state is PopularTvShowsError) {
                    return ViewError(message: 'Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: HEADING_TOP_RATED,
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvShowsPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvShowsCubit, TopRatedTvShowsState>(
                builder: (context, state) {
                  if (state is TopRatedTvShowsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvShowsHasData) {
                    return TvShowList(state.tvShows);
                  } else if (state is TopRatedTvShowsError) {
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

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                TvShowDetailPage.ROUTE_NAME,
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
