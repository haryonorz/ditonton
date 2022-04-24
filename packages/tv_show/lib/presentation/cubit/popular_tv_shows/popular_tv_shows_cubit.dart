import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';
import 'package:tv_show/presentation/cubit/popular_tv_shows/popular_tv_shows_state.dart';

class PopularTvShowsCubit extends Cubit<PopularTvShowsState> {
  final GetPopularTvShows _getPopularTvShows;

  PopularTvShowsCubit(this._getPopularTvShows) : super(PopularTvShowsEmpty());

  void fetchData() async {
    emit(PopularTvShowsLoading());

    final result = await _getPopularTvShows.execute();

    result.fold(
      (failure) {
        emit(PopularTvShowsError(failure.message));
      },
      (tvShowData) {
        emit(PopularTvShowsHasData(tvShowData));
        if (tvShowData.isEmpty) emit(PopularTvShowsEmpty());
      },
    );
  }
}
