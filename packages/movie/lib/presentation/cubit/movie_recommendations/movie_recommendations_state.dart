import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object?> get props => [];
}

class MovieRecommendationsEmpty extends MovieRecommendationsState {}

class MovieRecommendationsLoading extends MovieRecommendationsState {}

class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  const MovieRecommendationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieRecommendationsHasData extends MovieRecommendationsState {
  final List<Movie> movies;

  const MovieRecommendationsHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
