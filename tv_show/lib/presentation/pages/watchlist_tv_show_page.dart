import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/presentation/cubit/watchlist_tv_show/watchlist_tv_show_cubit.dart';
import 'package:tv_show/presentation/cubit/watchlist_tv_show/watchlist_tv_show_state.dart';

class WatchlistTvShowsPage extends StatefulWidget {
  const WatchlistTvShowsPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvShowsPageState createState() => _WatchlistTvShowsPageState();
}

class _WatchlistTvShowsPageState extends State<WatchlistTvShowsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistTvShowCubit>().fetchData(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvShowCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvShowCubit, WatchlistTvShowState>(
        builder: (context, state) {
          if (state is WatchlistTvShowLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvShowEmpty) {
            return const Center(
              key: Key('empty'),
              child: ViewError(message: 'No Data'),
            );
          } else if (state is WatchlistTvShowHasData) {
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
          } else if (state is WatchlistTvShowError) {
            return Center(
              key: const Key('error_message'),
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
