import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/presentation/cubit/movie_detail/movie_detail_state.dart';

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
