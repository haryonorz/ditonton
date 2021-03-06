// Mocks generated by Mockito 5.1.0 from annotations
// in search/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i14;
import 'dart:typed_data' as _i15;

import 'package:core/core.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/src/base_request.dart' as _i16;
import 'package:http/src/client.dart' as _i13;
import 'package:http/src/response.dart' as _i3;
import 'package:http/src/streamed_response.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/entities/movie.dart' as _i8;
import 'package:movie/domain/entities/movie_detail.dart' as _i9;
import 'package:movie/domain/repositories/movie_repository.dart' as _i5;
import 'package:tv_show/domain/entities/tv_show.dart' as _i11;
import 'package:tv_show/domain/entities/tv_show_detail.dart' as _i12;
import 'package:tv_show/domain/repositories/tv_show_repository.dart' as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeResponse_1 extends _i1.Fake implements _i3.Response {}

class _FakeStreamedResponse_2 extends _i1.Fake implements _i4.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i5.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>.value(
              _FakeEither_0<_i7.Failure, _i9.MovieDetail>())) as _i6
          .Future<_i2.Either<_i7.Failure, _i9.MovieDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i9.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [TvShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRepository extends _i1.Mock implements _i10.TvShowRepository {
  MockTvShowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>
      getNowPlayingTvShows() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i12.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, _i12.TvShowDetail>>.value(
              _FakeEither_0<_i7.Failure, _i12.TvShowDetail>())) as _i6
          .Future<_i2.Either<_i7.Failure, _i12.TvShowDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i12.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i12.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>
      getWatchlistTvShows() => (super.noSuchMethod(
          Invocation.method(#getWatchlistTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i11.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i11.TvShow>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i13.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i14.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i14.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i14.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<_i3.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i14.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i3.Response>.value(_FakeResponse_1()))
          as _i6.Future<_i3.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i15.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i15.Uint8List>.value(_i15.Uint8List(0)))
          as _i6.Future<_i15.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i16.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_2()))
          as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
