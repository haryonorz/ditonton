import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/search_event.dart';
import 'package:ditonton/presentation/bloc/search_state.dart';
import 'package:ditonton/presentation/cubit/menu_cubit.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:ditonton/presentation/widgets/view_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuItem>(
      builder: (context, menu) {
        final activeMenu = menu;
        final _title = (activeMenu == MenuItem.Movie) ? 'Movie' : 'Tv Show';

        return Scaffold(
          appBar: AppBar(
            title: Text('Search $_title'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (query) {
                    if (activeMenu == MenuItem.Movie)
                      context
                          .read<SearchMovieBloc>()
                          .add(OnQueryChanged(query));
                    else
                      context
                          .read<SearchTvShowBloc>()
                          .add(OnQueryChanged(query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.search,
                ),
                SizedBox(height: 16),
                Text(
                  'Search Result',
                  style: kHeading6,
                ),
                activeMenu == MenuItem.Movie ? MovieResult() : TvShowResult(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MovieResult extends StatelessWidget {
  const MovieResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMovieBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchEmpty) {
          return Expanded(child: ViewError(message: 'No Data'));
        } else if (state is SearchHasData<Movie>) {
          var result = state.result;

          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return ContentCard(
                  activeMenu: MenuItem.Movie,
                  movie: movie,
                  routeName: MovieDetailPage.ROUTE_NAME,
                );
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            child: ViewError(message: state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class TvShowResult extends StatelessWidget {
  const TvShowResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTvShowBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchEmpty) {
          return Expanded(child: ViewError(message: 'No Data'));
        } else if (state is SearchHasData<TvShow>) {
          var result = state.result;

          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvShow = result[index];
                return ContentCard(
                  activeMenu: MenuItem.TvShow,
                  tvShow: tvShow,
                  routeName: MovieDetailPage.ROUTE_NAME,
                );
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            child: ViewError(message: state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
