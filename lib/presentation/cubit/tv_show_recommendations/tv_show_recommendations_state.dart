import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class TvShowRecommendationsState extends Equatable {
  const TvShowRecommendationsState();

  @override
  List<Object?> get props => [];
}

class TvShowRecommendationsEmpty extends TvShowRecommendationsState {}

class TvShowRecommendationsLoading extends TvShowRecommendationsState {}

class TvShowRecommendationsError extends TvShowRecommendationsState {
  final String message;

  TvShowRecommendationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvShowRecommendationsHasData extends TvShowRecommendationsState {
  final List<TvShow> tvShows;

  TvShowRecommendationsHasData(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}
