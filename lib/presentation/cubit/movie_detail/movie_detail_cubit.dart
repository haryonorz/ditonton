import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/presentation/cubit/movie_detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailCubit(this._getMovieDetail) : super(MovieDetailEmpty());

  void fetchData(int id) async {
    emit(MovieDetailLoading());

    final result = await _getMovieDetail.execute(id);

    result.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (movie) {
        emit(MovieDetailHasData(movie));
      },
    );
  }
}
