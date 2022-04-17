import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv_show/presentation/cubit/tv_show_recommendations/tv_show_recommendations_state.dart';

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
