import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/usecases/get_tv_show_detail.dart';
import 'package:tv_show/presentation/cubit/tv_show_detail/tv_show_detail_state.dart';

class TvShowDetailCubit extends Cubit<TvShowDetailState> {
  final GetTvShowDetail _getTvShowDetail;

  TvShowDetailCubit(this._getTvShowDetail) : super(TvShowDetailEmpty());

  void fetchData(int id) async {
    emit(TvShowDetailLoading());

    final result = await _getTvShowDetail.execute(id);

    result.fold(
      (failure) {
        emit(TvShowDetailError(failure.message));
      },
      (movie) {
        emit(TvShowDetailHasData(movie));
      },
    );
  }
}
