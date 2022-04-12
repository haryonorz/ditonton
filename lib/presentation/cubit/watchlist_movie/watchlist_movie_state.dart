import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistMovieMessage extends WatchlistMovieState {
  final String message;

  WatchlistMovieMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> movies;

  WatchlistMovieHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieIsAddedToWatchlist extends WatchlistMovieState {
  final bool isAdded;

  MovieIsAddedToWatchlist(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}
