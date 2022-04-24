import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';
import 'package:tv_show/domain/repositories/tv_show_repository.dart';

class RemoveWatchlistTvShow {
  final TvShowRepository repository;

  RemoveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.removeWatchlist(tvShow);
  }
}
