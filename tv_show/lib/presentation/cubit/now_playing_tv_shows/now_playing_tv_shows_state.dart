import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

abstract class NowPlayingTvShowsState extends Equatable {
  const NowPlayingTvShowsState();

  @override
  List<Object?> get props => [];
}

class NowPlayingTvShowsEmpty extends NowPlayingTvShowsState {}

class NowPlayingTvShowsLoading extends NowPlayingTvShowsState {}

class NowPlayingTvShowsError extends NowPlayingTvShowsState {
  final String message;

  const NowPlayingTvShowsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NowPlayingTvShowsHasData extends NowPlayingTvShowsState {
  final List<TvShow> tvShows;

  const NowPlayingTvShowsHasData(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}
