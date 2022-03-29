import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetWatchListStatus {
  final TvShowRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
