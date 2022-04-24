import 'package:equatable/equatable.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

abstract class TvShowRecommendationsState extends Equatable {
  const TvShowRecommendationsState();

  @override
  List<Object?> get props => [];
}

class TvShowRecommendationsEmpty extends TvShowRecommendationsState {}

class TvShowRecommendationsLoading extends TvShowRecommendationsState {}

class TvShowRecommendationsError extends TvShowRecommendationsState {
  final String message;

  const TvShowRecommendationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvShowRecommendationsHasData extends TvShowRecommendationsState {
  final List<TvShow> tvShows;

  const TvShowRecommendationsHasData(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}
