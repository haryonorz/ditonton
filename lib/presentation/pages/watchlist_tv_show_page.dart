import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/cubit/watchlist_tv_show/watchlist_tv_show_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_tv_show/watchlist_tv_show_state.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvShowsPage extends StatefulWidget {
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
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvShowEmpty) {
            return Center(
              child: ViewError(message: 'No Data'),
            );
          } else if (state is WatchlistTvShowHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = state.tvShows[index];
                return ContentCard(
                  activeMenu: MenuItem.TvShow,
                  tvShow: tvShow,
                  routeName: TvShowDetailPage.ROUTE_NAME,
                );
              },
              itemCount: state.tvShows.length,
            );
          } else if (state is WatchlistTvShowError) {
            return Center(
              key: Key('error_message'),
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
