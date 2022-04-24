import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/presentation/cubit/popular_tv_shows/popular_tv_shows_cubit.dart';
import 'package:tv_show/presentation/cubit/popular_tv_shows/popular_tv_shows_state.dart';

class PopularTvShowsPage extends StatefulWidget {
  const PopularTvShowsPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PopularTvShowsCubit>().fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$headingPopular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowsCubit, PopularTvShowsState>(
          builder: (context, state) {
            if (state is PopularTvShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvShowsEmpty) {
              return const Center(
                key: Key('empty'),
                child: ViewError(message: 'No Data'),
              );
            } else if (state is PopularTvShowsHasData) {
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
            } else if (state is PopularTvShowsError) {
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
