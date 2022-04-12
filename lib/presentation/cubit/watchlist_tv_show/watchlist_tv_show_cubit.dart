import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_status_tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/remove_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/save_watchlist_tv_show.dart';
import 'package:ditonton/presentation/cubit/watchlist_tv_show/watchlist_tv_show_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvShowCubit extends Cubit<WatchlistTvShowState> {
  final GetWatchlistTvShows _getWatchlistTvShows;
  final GetWatchlistStatusTvShow _getWatchListStatus;
  final SaveWatchlistTvShow _saveWatchlist;
  final RemoveWatchlistTvShow _removeWatchlist;

  WatchlistTvShowCubit(
    this._getWatchlistTvShows,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(WatchlistTvShowEmpty());

  void fetchData() async {
    emit(WatchlistTvShowLoading());

    final result = await _getWatchlistTvShows.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvShowError(failure.message));
      },
      (tvShowData) {
        emit(WatchlistTvShowHasData(tvShowData));
        if (tvShowData.isEmpty) emit(WatchlistTvShowEmpty());
      },
    );
  }

  void addToWatchlist(TvShowDetail tvShowDetail) async {
    final result = await _saveWatchlist.execute(tvShowDetail);

    result.fold(
      (failure) {
        WatchlistTvShowMessage(failure.message);
      },
      (successMessage) {
        WatchlistTvShowMessage(successMessage);
      },
    );

    loadWatchlistStatus(tvShowDetail.id);
  }

  void removeFromWatchlist(TvShowDetail tvShowDetail) async {
    final result = await _removeWatchlist.execute(tvShowDetail);

    result.fold(
      (failure) {
        WatchlistTvShowMessage(failure.message);
      },
      (successMessage) {
        WatchlistTvShowMessage(successMessage);
      },
    );

    loadWatchlistStatus(tvShowDetail.id);
  }

  void loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(TvShowIsAddedToWatchlist(result));
  }
}
