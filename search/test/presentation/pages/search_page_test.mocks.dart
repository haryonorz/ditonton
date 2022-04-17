// Mocks generated by Mockito 5.1.0 from annotations
// in search/test/presentation/pages/search_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/presentation/cubit/menu_cubit.dart' as _i7;
import 'package:core/utils/menu_enum.dart' as _i8;
import 'package:flutter_bloc/flutter_bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:search/presentation/bloc/search_bloc.dart' as _i3;
import 'package:search/presentation/bloc/search_event.dart' as _i5;
import 'package:search/presentation/bloc/search_state.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSearchState_0 extends _i1.Fake implements _i2.SearchState {}

/// A class which mocks [SearchMovieBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovieBloc extends _i1.Mock implements _i3.SearchMovieBloc {
  MockSearchMovieBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SearchState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeSearchState_0()) as _i2.SearchState);
  @override
  _i4.Stream<_i2.SearchState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.SearchState>.empty())
          as _i4.Stream<_i2.SearchState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i5.SearchEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i5.SearchEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i2.SearchState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i5.SearchEvent>(
          _i6.EventHandler<E, _i2.SearchState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i5.SearchEvent, _i2.SearchState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void onChange(_i6.Change<_i2.SearchState>? change) =>
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
}

/// A class which mocks [SearchTvShowBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchTvShowBloc extends _i1.Mock implements _i3.SearchTvShowBloc {
  MockSearchTvShowBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SearchState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeSearchState_0()) as _i2.SearchState);
  @override
  _i4.Stream<_i2.SearchState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.SearchState>.empty())
          as _i4.Stream<_i2.SearchState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i5.SearchEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i5.SearchEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i2.SearchState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i5.SearchEvent>(
          _i6.EventHandler<E, _i2.SearchState>? handler,
          {_i6.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i6.Transition<_i5.SearchEvent, _i2.SearchState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void onChange(_i6.Change<_i2.SearchState>? change) =>
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
}

/// A class which mocks [MenuCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockMenuCubit extends _i1.Mock implements _i7.MenuCubit {
  MockMenuCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.MenuItem get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i8.MenuItem.movie) as _i8.MenuItem);
  @override
  _i4.Stream<_i8.MenuItem> get stream => (super.noSuchMethod(
      Invocation.getter(#stream),
      returnValue: Stream<_i8.MenuItem>.empty()) as _i4.Stream<_i8.MenuItem>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void setSelectedMenu(_i8.MenuItem? menu) =>
      super.noSuchMethod(Invocation.method(#setSelectedMenu, [menu]),
          returnValueForMissingStub: null);
  @override
  void emit(_i8.MenuItem? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i6.Change<_i8.MenuItem>? change) =>
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
