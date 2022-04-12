import 'package:ditonton/common/http_ssl_pinning.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_show_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_status_tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/remove_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/save_watchlist_tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/cubit/menu_cubit.dart';
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
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => NowPlayingMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieCubit(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvShowsCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowRecommendationsCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvShowBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowsCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvShowsCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvShowCubit(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => MenuCubit(),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatusTvShow(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
