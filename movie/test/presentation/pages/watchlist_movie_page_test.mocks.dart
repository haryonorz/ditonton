// Mocks generated by Mockito 5.1.0 from annotations
// in movie/test/presentation/pages/watchlist_movie_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_bloc/flutter_bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/entities/movie_detail.dart' as _i5;
import 'package:movie/presentation/cubit/watchlist_movie/watchlist_movie_cubit.dart'
    as _i3;
import 'package:movie/presentation/cubit/watchlist_movie/watchlist_movie_state.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeWatchlistMovieState_0 extends _i1.Fake
    implements _i2.WatchlistMovieState {}

/// A class which mocks [WatchlistMovieCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistMovieCubit extends _i1.Mock
    implements _i3.WatchlistMovieCubit {
  MockWatchlistMovieCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WatchlistMovieState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _FakeWatchlistMovieState_0()) as _i2.WatchlistMovieState);
  @override
  _i4.Stream<_i2.WatchlistMovieState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.WatchlistMovieState>.empty())
          as _i4.Stream<_i2.WatchlistMovieState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void fetchData() => super.noSuchMethod(Invocation.method(#fetchData, []),
      returnValueForMissingStub: null);
  @override
  void addToWatchlist(_i5.MovieDetail? movie) =>
      super.noSuchMethod(Invocation.method(#addToWatchlist, [movie]),
          returnValueForMissingStub: null);
  @override
  void removeFromWatchlist(_i5.MovieDetail? movie) =>
      super.noSuchMethod(Invocation.method(#removeFromWatchlist, [movie]),
          returnValueForMissingStub: null);
  @override
  void loadWatchlistStatus(int? id) =>
      super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
          returnValueForMissingStub: null);
  @override
  void emit(_i2.WatchlistMovieState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i6.Change<_i2.WatchlistMovieState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}