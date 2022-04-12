import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();

  @override
  List<Object?> get props => [];
}

class TvShowDetailEmpty extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailError extends TvShowDetailState {
  final String message;

  TvShowDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvShowDetailHasData extends TvShowDetailState {
  final TvShowDetail tvShow;

  TvShowDetailHasData(this.tvShow);

  @override
  List<Object?> get props => [tvShow];
}
