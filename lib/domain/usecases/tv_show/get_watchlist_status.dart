import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetWatchlistStatus {
  final TvShowRepository repository;

  GetWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
