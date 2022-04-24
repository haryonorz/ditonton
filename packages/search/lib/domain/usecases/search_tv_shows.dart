import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/repositories/tv_show_repository.dart';

class SearchTvShows {
  final TvShowRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}
