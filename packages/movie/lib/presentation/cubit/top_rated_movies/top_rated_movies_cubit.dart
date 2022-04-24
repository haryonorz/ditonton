import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/cubit/top_rated_movies/top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesCubit(this._getTopRatedMovies) : super(TopRatedMoviesEmpty());

  void fetchData() async {
    emit(TopRatedMoviesLoading());

    final result = await _getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(TopRatedMoviesError(failure.message));
      },
      (moviesData) {
        emit(TopRatedMoviesHasData(moviesData));
        if (moviesData.isEmpty) emit(TopRatedMoviesEmpty());
      },
    );
  }
}
