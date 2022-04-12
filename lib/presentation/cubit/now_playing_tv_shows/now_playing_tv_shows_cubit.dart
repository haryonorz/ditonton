import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:ditonton/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvShowsCubit extends Cubit<NowPlayingTvShowsState> {
  final GetNowPlayingTvShows _getNowPlayingTvShows;

  NowPlayingTvShowsCubit(
    this._getNowPlayingTvShows,
  ) : super(NowPlayingTvShowsEmpty());

  void fetchData() async {
    emit(NowPlayingTvShowsLoading());

    final result = await _getNowPlayingTvShows.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTvShowsError(failure.message));
      },
      (tvShowData) {
        emit(NowPlayingTvShowsHasData(tvShowData));
        if (tvShowData.isEmpty) emit(NowPlayingTvShowsEmpty());
      },
    );
  }
}
