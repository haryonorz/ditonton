import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/presentation/cubit/popular_tv_shows/popular_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_tv_shows/popular_tv_shows_state.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-show';

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
        title: Text('$HEADING_POPULAR Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowsCubit, PopularTvShowsState>(
          builder: (context, state) {
            if (state is PopularTvShowsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvShowsEmpty) {
              return Center(
                child: ViewError(message: 'No Data'),
              );
            } else if (state is PopularTvShowsHasData) {
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
            } else if (state is PopularTvShowsError) {
              return Center(
                key: Key('error_message'),
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
