import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/presentation/cubit/top_rated_tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:tv_show/presentation/cubit/top_rated_tv_shows/top_rated_tv_shows_state.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  const TopRatedTvShowsPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvShowsPageState createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedTvShowsCubit>().fetchData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$headingTopRated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvShowsCubit, TopRatedTvShowsState>(
          builder: (context, state) {
            if (state is TopRatedTvShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvShowsEmpty) {
              return const Center(
                key: Key('empty'),
                child: ViewError(message: 'No Data'),
              );
            } else if (state is TopRatedTvShowsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvShows[index];
                  return ContentCard(
                    activeMenu: MenuItem.tvShow,
                    tvShow: tvShow,
                    routeName: tvShowDetailRoute,
                  );
                },
                itemCount: state.tvShows.length,
              );
            } else if (state is TopRatedTvShowsError) {
              return Center(
                key: const Key('error_message'),
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
