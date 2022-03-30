import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:flutter/material.dart';

class TopRatedTvShowsNotifier extends ChangeNotifier {
  final GetTopRatedTvShows getTopRatedTvShows;

  TopRatedTvShowsNotifier({required this.getTopRatedTvShows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
      },
      (tvShowsData) {
        _state = RequestState.Loaded;
        _tvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
