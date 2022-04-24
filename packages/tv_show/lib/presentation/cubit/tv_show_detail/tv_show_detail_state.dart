import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();

  @override
  List<Object?> get props => [];
}

class TvShowDetailEmpty extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailError extends TvShowDetailState {
  final String message;

  const TvShowDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvShowDetailHasData extends TvShowDetailState {
  final TvShowDetail tvShow;

  const TvShowDetailHasData(this.tvShow);

  @override
  List<Object?> get props => [tvShow];
}
