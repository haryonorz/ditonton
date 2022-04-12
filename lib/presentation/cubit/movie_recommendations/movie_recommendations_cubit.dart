import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/cubit/movie_recommendations/movie_recommendations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieRecommendationsCubit extends Cubit<MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsCubit(this._getMovieRecommendations)
      : super(MovieRecommendationsEmpty());

  void fetchData(int id) async {
    emit(MovieRecommendationsLoading());

    final result = await _getMovieRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(MovieRecommendationsError(failure.message));
      },
      (moviesData) {
        emit(MovieRecommendationsHasData(moviesData));
        if (moviesData.isEmpty) emit(MovieRecommendationsEmpty());
      },
    );
  }
}
