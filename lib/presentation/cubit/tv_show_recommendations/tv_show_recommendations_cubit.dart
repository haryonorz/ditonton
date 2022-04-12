import 'package:ditonton/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:ditonton/presentation/cubit/tv_show_recommendations/tv_show_recommendations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowRecommendationsCubit extends Cubit<TvShowRecommendationsState> {
  final GetTvShowRecommendations _getTvShowRecommendations;

  TvShowRecommendationsCubit(this._getTvShowRecommendations)
      : super(TvShowRecommendationsEmpty());

  void fetchData(int id) async {
    emit(TvShowRecommendationsLoading());

    final result = await _getTvShowRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(TvShowRecommendationsError(failure.message));
      },
      (tvShowData) {
        emit(TvShowRecommendationsHasData(tvShowData));
        if (tvShowData.isEmpty) emit(TvShowRecommendationsEmpty());
      },
    );
  }
}
