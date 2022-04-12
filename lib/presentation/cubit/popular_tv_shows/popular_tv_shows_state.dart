import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class PopularTvShowsState extends Equatable {
  const PopularTvShowsState();

  @override
  List<Object?> get props => [];
}

class PopularTvShowsEmpty extends PopularTvShowsState {}

class PopularTvShowsLoading extends PopularTvShowsState {}

class PopularTvShowsError extends PopularTvShowsState {
  final String message;

  PopularTvShowsError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularTvShowsHasData extends PopularTvShowsState {
  final List<TvShow> tvShows;

  PopularTvShowsHasData(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}
