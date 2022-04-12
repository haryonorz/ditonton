import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/http_ssl_pinning.dart';
import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/movie_recommendations/movie_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_tv_shows/popular_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv_shows/top_rated_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_show_detail/tv_show_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_show_recommendations/tv_show_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_tv_show/watchlist_tv_show_cubit.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_tv_show_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/widgets/custom_darawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'presentation/cubit/menu_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<NowPlayingMoviesCubit>()),
        BlocProvider(create: (_) => di.locator<MovieDetailCubit>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationsCubit>()),
        BlocProvider(create: (_) => di.locator<SearchMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesCubit>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesCubit>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieCubit>()),
        BlocProvider(create: (_) => di.locator<NowPlayingTvShowsCubit>()),
        BlocProvider(create: (_) => di.locator<TvShowDetailCubit>()),
        BlocProvider(create: (_) => di.locator<TvShowRecommendationsCubit>()),
        BlocProvider(create: (_) => di.locator<SearchTvShowBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvShowsCubit>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvShowsCubit>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvShowCubit>()),
        BlocProvider(create: (_) => di.locator<MenuCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: BlocBuilder<MenuCubit, MenuItem>(
          builder: (context, menu) {
            final activeMenu = menu;

            return Material(
              child: CustomDrawer(
                activeMenu: activeMenu,
                menuClickCallback: (MenuItem menuSelected) {
                  context.read<MenuCubit>().setSelectedMenu(menuSelected);
                },
                content: activeMenu == MenuItem.Movie
                    ? HomeMoviePage()
                    : HomeTvShowPage(),
              ),
            );
          },
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvShowsPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowsPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => SearchPage(),
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
