import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv_show/presentation/pages/watchlist_tv_show_page.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: kGrey,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: kDavysGrey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(child: Text('Movie')),
                    Tab(child: Text('Tv Show')),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    WatchlistMoviesPage(),
                    WatchlistTvShowsPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
