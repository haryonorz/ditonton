import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetWatchlistStatusTvShow {
  final TvShowRepository repository;

  GetWatchlistStatusTvShow(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
