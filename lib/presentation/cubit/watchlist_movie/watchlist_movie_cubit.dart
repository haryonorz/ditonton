import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist_movie.dart';
import 'package:ditonton/presentation/cubit/watchlist_movie/watchlist_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatusMovie _getWatchListStatus;
  final SaveWatchlistMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;

  WatchlistMovieCubit(
    this._getWatchlistMovies,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(WatchlistMovieEmpty());

  void fetchData() async {
    emit(WatchlistMovieLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(WatchlistMovieError(failure.message));
      },
      (moviesData) {
        emit(WatchlistMovieHasData(moviesData));
        if (moviesData.isEmpty) emit(WatchlistMovieEmpty());
      },
    );
  }

  void addToWatchlist(MovieDetail movie) async {
    final result = await _saveWatchlist.execute(movie);

    result.fold(
      (failure) {
        WatchlistMovieMessage(failure.message);
      },
      (successMessage) {
        WatchlistMovieMessage(successMessage);
      },
    );

    loadWatchlistStatus(movie.id);
  }

  void removeFromWatchlist(MovieDetail movie) async {
    final result = await _removeWatchlist.execute(movie);

    result.fold(
      (failure) {
        WatchlistMovieMessage(failure.message);
      },
      (successMessage) {
        WatchlistMovieMessage(successMessage);
      },
    );

    loadWatchlistStatus(movie.id);
  }

  void loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(MovieIsAddedToWatchlist(result));
  }
}
