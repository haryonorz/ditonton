import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/cubit/top_rated_movies/top_rated_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
