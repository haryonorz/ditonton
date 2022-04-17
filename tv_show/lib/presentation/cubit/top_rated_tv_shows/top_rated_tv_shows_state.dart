import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

abstract class TopRatedTvShowsState extends Equatable {
  const TopRatedTvShowsState();

  @override
  List<Object?> get props => [];
}

class TopRatedTvShowsEmpty extends TopRatedTvShowsState {}

class TopRatedTvShowsLoading extends TopRatedTvShowsState {}

class TopRatedTvShowsError extends TopRatedTvShowsState {
  final String message;

  const TopRatedTvShowsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TopRatedTvShowsHasData extends TopRatedTvShowsState {
  final List<TvShow> tvShows;

  const TopRatedTvShowsHasData(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}
