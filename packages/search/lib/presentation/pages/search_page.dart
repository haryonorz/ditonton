import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/presentation/bloc/search_state.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuItem>(
      builder: (context, menu) {
        final activeMenu = menu;
        final _title = (activeMenu == MenuItem.movie) ? 'Movie' : 'Tv Show';

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
                  key: const Key('query_input'),
                  onChanged: (query) {
                    if (activeMenu == MenuItem.movie) {
                      context
                          .read<SearchMovieBloc>()
                          .add(OnQueryChanged(query));
                    } else {
                      context
                          .read<SearchTvShowBloc>()
                          .add(OnQueryChanged(query));
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search title',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.search,
                ),
                const SizedBox(height: 16),
                Text(
                  'Search Result',
                  style: kHeading6,
                ),
                activeMenu == MenuItem.movie
                    ? const MovieResult()
                    : const TvShowResult(),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchEmpty) {
          return const Expanded(
            key: Key('empty'),
            child: ViewError(message: 'No Data'),
          );
        } else if (state is SearchHasData<Movie>) {
          var result = state.result;

          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final movie = result[index];
                return ContentCard(
                  activeMenu: MenuItem.movie,
                  movie: movie,
                  routeName: movieDetailRoute,
                );
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            key: const Key('error_message'),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchEmpty) {
          return const Expanded(
            key: Key('empty'),
            child: ViewError(message: 'No Data'),
          );
        } else if (state is SearchHasData<TvShow>) {
          var result = state.result;

          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final tvShow = result[index];
                return ContentCard(
                  activeMenu: MenuItem.tvShow,
                  tvShow: tvShow,
                  routeName: tvShowDetailRoute,
                );
              },
              itemCount: result.length,
            ),
          );
        } else if (state is SearchError) {
          return Expanded(
            key: const Key('error_message'),
            child: ViewError(message: state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
