import 'package:ditonton/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/cubit/top_rated_tv_shows/top_rated_tv_shows_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvShowsCubit extends Cubit<TopRatedTvShowsState> {
  final GetTopRatedTvShows _getTopRatedTvShows;

  TopRatedTvShowsCubit(this._getTopRatedTvShows)
      : super(TopRatedTvShowsEmpty());

  void fetchData() async {
    emit(TopRatedTvShowsLoading());

    final result = await _getTopRatedTvShows.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvShowsError(failure.message));
      },
      (tvShowData) {
        emit(TopRatedTvShowsHasData(tvShowData));
        if (tvShowData.isEmpty) emit(TopRatedTvShowsEmpty());
      },
    );
  }
}
