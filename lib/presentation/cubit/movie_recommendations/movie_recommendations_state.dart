import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object?> get props => [];
}

class MovieRecommendationsEmpty extends MovieRecommendationsState {}

class MovieRecommendationsLoading extends MovieRecommendationsState {}

class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  MovieRecommendationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieRecommendationsHasData extends MovieRecommendationsState {
  final List<Movie> movies;

  MovieRecommendationsHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
