import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

abstract class WatchlistTvShowState extends Equatable {
  const WatchlistTvShowState();

  @override
  List<Object?> get props => [];
}

class WatchlistTvShowEmpty extends WatchlistTvShowState {}

class WatchlistTvShowLoading extends WatchlistTvShowState {}

class WatchlistTvShowError extends WatchlistTvShowState {
  final String message;

  const WatchlistTvShowError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTvShowMessage extends WatchlistTvShowState {
  final String message;

  const WatchlistTvShowMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTvShowHasData extends WatchlistTvShowState {
  final List<TvShow> tvShows;

  const WatchlistTvShowHasData(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}

class TvShowIsAddedToWatchlist extends WatchlistTvShowState {
  final bool isAdded;

  const TvShowIsAddedToWatchlist(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}
