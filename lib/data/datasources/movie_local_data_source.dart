import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(TvShowTable movie);
  Future<String> removeWatchlist(TvShowTable movie);
  Future<TvShowTable?> getMovieById(int id);
  Future<List<TvShowTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvShowTable movie) async {
    try {
      await databaseHelper.insertWatchlistMovie(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvShowTable movie) async {
    try {
      await databaseHelper.removeWatchlistMovie(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvShowTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => TvShowTable.fromMap(data)).toList();
  }
}
