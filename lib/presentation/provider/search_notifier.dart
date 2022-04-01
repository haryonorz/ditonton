import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:flutter/foundation.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvShows searchTvShows;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvShows,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _searchMovieResult = [];
  List<Movie> get searchMovieResult => _searchMovieResult;

  List<TvShow> _searchTvShowResult = [];
  List<TvShow> get searchTvShowResult => _searchTvShowResult;

  String _message = '';
  String get message => _message;

  void resetData() {
    _state = RequestState.Empty;
    _searchMovieResult = [];
    _searchTvShowResult = [];
    notifyListeners();
  }

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchMovieResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchTvShowResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
