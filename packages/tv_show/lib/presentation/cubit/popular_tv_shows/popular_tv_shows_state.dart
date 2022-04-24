import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

abstract class PopularTvShowsState extends Equatable {
  const PopularTvShowsState();

  @override
  List<Object?> get props => [];
}

class PopularTvShowsEmpty extends PopularTvShowsState {}

class PopularTvShowsLoading extends PopularTvShowsState {}

class PopularTvShowsError extends PopularTvShowsState {
  final String message;

  const PopularTvShowsError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularTvShowsHasData extends PopularTvShowsState {
  final List<TvShow> tvShows;

  const PopularTvShowsHasData(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}
