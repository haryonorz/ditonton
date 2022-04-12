import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/search_event.dart';
import 'package:ditonton/presentation/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchMovieBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  SearchMovieBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchLoading());
      final result = await _searchMovies.execute(query);
      result.fold((failure) => emit(SearchError(failure.message)),
          (moviesData) {
        emit(SearchHasData<Movie>(moviesData));
        if (moviesData.isEmpty) {
          emit(SearchEmpty());
        }
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

class SearchTvShowBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvShows _searchTvShows;
  SearchTvShowBloc(this._searchTvShows) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchLoading());
      final result = await _searchTvShows.execute(query);
      result.fold((failure) => emit(SearchError(failure.message)),
          (tvShowsData) {
        emit(SearchHasData<TvShow>(tvShowsData));
        if (tvShowsData.isEmpty) {
          emit(SearchEmpty());
        }
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
