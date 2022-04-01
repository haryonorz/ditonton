import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/provider/drawer_notifier.dart';
import 'package:ditonton/presentation/provider/search_notifier.dart';
import 'package:ditonton/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<SearchNotifier>(context, listen: false).resetData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuNotifier>(builder: (context, data, child) {
      final activeMenu = data.selectedMenu;
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
                onSubmitted: (query) {
                  if (activeMenu == MenuItem.Movie)
                    Provider.of<SearchNotifier>(context, listen: false)
                        .fetchMovieSearch(query);
                  else
                    Provider.of<SearchNotifier>(context, listen: false)
                        .fetchTvShowSearch(query);
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
              Consumer<SearchNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.Loaded) {
                    var result;
                    if (activeMenu == MenuItem.Movie)
                      result = data.searchMovieResult;
                    else
                      result = data.searchTvShowResult;

                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          if (activeMenu == MenuItem.Movie) {
                            final movie = data.searchMovieResult[index];
                            return ContentCard(
                              activeMenu: MenuItem.Movie,
                              movie: movie,
                              routeName: MovieDetailPage.ROUTE_NAME,
                            );
                          } else {
                            final tvShow = data.searchTvShowResult[index];
                            return ContentCard(
                              activeMenu: MenuItem.TvShow,
                              tvShow: tvShow,
                              routeName: TvShowDetailPage.ROUTE_NAME,
                            );
                          }
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
