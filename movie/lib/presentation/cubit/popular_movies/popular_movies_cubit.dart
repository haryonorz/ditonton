import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/cubit/popular_movies/popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesCubit(this._getPopularMovies) : super(PopularMoviesEmpty());

  void fetchData() async {
    emit(PopularMoviesLoading());

    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (moviesData) {
        emit(PopularMoviesHasData(moviesData));
        if (moviesData.isEmpty) emit(PopularMoviesEmpty());
      },
    );
  }
}
