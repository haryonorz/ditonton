import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/usecases/get_now_playing_tv_shows.dart';
import 'package:tv_show/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_state.dart';

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
