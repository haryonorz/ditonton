import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/cubit/now_playing_movies/now_playing_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesCubit(
    this._getNowPlayingMovies,
  ) : super(NowPlayingMoviesEmpty());

  void fetchData() async {
    emit(NowPlayingMoviesLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMoviesError(failure.message));
      },
      (moviesData) {
        emit(NowPlayingMoviesHasData(moviesData));
        if (moviesData.isEmpty) emit(NowPlayingMoviesEmpty());
      },
    );
  }
}
