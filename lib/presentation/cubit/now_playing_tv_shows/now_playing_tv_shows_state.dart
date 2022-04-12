import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class NowPlayingTvShowsState extends Equatable {
  const NowPlayingTvShowsState();

  @override
  List<Object?> get props => [];
}

class NowPlayingTvShowsEmpty extends NowPlayingTvShowsState {}

class NowPlayingTvShowsLoading extends NowPlayingTvShowsState {}

class NowPlayingTvShowsError extends NowPlayingTvShowsState {
  final String message;

  NowPlayingTvShowsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NowPlayingTvShowsHasData extends NowPlayingTvShowsState {
  final List<TvShow> tvShows;

  NowPlayingTvShowsHasData(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}
