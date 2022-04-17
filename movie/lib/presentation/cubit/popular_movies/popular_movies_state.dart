import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object?> get props => [];
}

class PopularMoviesEmpty extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState {}

class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> movies;

  const PopularMoviesHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
