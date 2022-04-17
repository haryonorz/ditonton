import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/search.dart';
import 'package:tv_show/tv_show.dart';

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
                content: activeMenu == MenuItem.movie
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
            case popularMovieRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case popularTvShowRoute:
              return CupertinoPageRoute(builder: (_) => PopularTvShowsPage());
            case topRatedMovieRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case topRatedTvShowRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowsPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case tvShowDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case searchRoute:
              return CupertinoPageRoute(
                builder: (_) => SearchPage(),
              );
            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case aboutRoute:
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
