// Mocks generated by Mockito 5.1.0 from annotations
// in tv_show/test/helper/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i16;
import 'dart:typed_data' as _i17;

import 'package:core/core.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/data/models/movie_table.dart' as _i15;
import 'package:sqflite/sqflite.dart' as _i14;
import 'package:tv_show/data/datasources/tv_show_local_data_source.dart'
    as _i12;
import 'package:tv_show/data/datasources/tv_show_remote_data_source.dart'
    as _i10;
import 'package:tv_show/data/models/tv_show_detail_model.dart' as _i3;
import 'package:tv_show/data/models/tv_show_model.dart' as _i11;
import 'package:tv_show/data/models/tv_show_table.dart' as _i13;
import 'package:tv_show/domain/entities/tv_show.dart' as _i8;
import 'package:tv_show/domain/entities/tv_show_detail.dart' as _i9;
import 'package:tv_show/domain/repositories/tv_show_repository.dart' as _i5;

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

class _FakeTvShowDetailResponse_1 extends _i1.Fake
    implements _i3.TvShowDetailResponse {}

class _FakeResponse_2 extends _i1.Fake implements _i4.Response {}

class _FakeStreamedResponse_3 extends _i1.Fake implements _i4.StreamedResponse {
}

/// A class which mocks [TvShowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRepository extends _i1.Mock implements _i5.TvShowRepository {
  MockTvShowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>
      getNowPlayingTvShows() =>
          (super.noSuchMethod(Invocation.method(#getNowPlayingTvShows, []),
                  returnValue:
                      Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>.value(
                          _FakeEither_0<_i7.Failure, List<_i8.TvShow>>()))
              as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.TvShowDetail>> getTvShowDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, _i9.TvShowDetail>>.value(
              _FakeEither_0<_i7.Failure, _i9.TvShowDetail>())) as _i6
          .Future<_i2.Either<_i7.Failure, _i9.TvShowDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>
      getTvShowRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>> searchTvShows(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> saveWatchlist(
          _i9.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, String>> removeWatchlist(
          _i9.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i7.Failure, String>>.value(
                  _FakeEither_0<_i7.Failure, String>()))
          as _i6.Future<_i2.Either<_i7.Failure, String>>);
  @override
  _i6.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
          returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>.value(
              _FakeEither_0<_i7.Failure, List<_i8.TvShow>>())) as _i6
          .Future<_i2.Either<_i7.Failure, List<_i8.TvShow>>>);
}

/// A class which mocks [TvShowRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowRemoteDataSource extends _i1.Mock
    implements _i10.TvShowRemoteDataSource {
  MockTvShowRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.TvShowModel>> getNowPlayingTvShows() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvShows, []),
              returnValue:
                  Future<List<_i11.TvShowModel>>.value(<_i11.TvShowModel>[]))
          as _i6.Future<List<_i11.TvShowModel>>);
  @override
  _i6.Future<List<_i11.TvShowModel>> getPopularTvShows() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShows, []),
              returnValue:
                  Future<List<_i11.TvShowModel>>.value(<_i11.TvShowModel>[]))
          as _i6.Future<List<_i11.TvShowModel>>);
  @override
  _i6.Future<List<_i11.TvShowModel>> getTopRatedTvShows() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShows, []),
              returnValue:
                  Future<List<_i11.TvShowModel>>.value(<_i11.TvShowModel>[]))
          as _i6.Future<List<_i11.TvShowModel>>);
  @override
  _i6.Future<_i3.TvShowDetailResponse> getTvShowDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowDetail, [id]),
              returnValue: Future<_i3.TvShowDetailResponse>.value(
                  _FakeTvShowDetailResponse_1()))
          as _i6.Future<_i3.TvShowDetailResponse>);
  @override
  _i6.Future<List<_i11.TvShowModel>> getTvShowRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowRecommendations, [id]),
              returnValue:
                  Future<List<_i11.TvShowModel>>.value(<_i11.TvShowModel>[]))
          as _i6.Future<List<_i11.TvShowModel>>);
  @override
  _i6.Future<List<_i11.TvShowModel>> searchTvShows(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvShows, [query]),
              returnValue:
                  Future<List<_i11.TvShowModel>>.value(<_i11.TvShowModel>[]))
          as _i6.Future<List<_i11.TvShowModel>>);
}

/// A class which mocks [TvShowLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowLocalDataSource extends _i1.Mock
    implements _i12.TvShowLocalDataSource {
  MockTvShowLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i13.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(_i13.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i13.TvShowTable?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<_i13.TvShowTable?>.value())
          as _i6.Future<_i13.TvShowTable?>);
  @override
  _i6.Future<List<_i13.TvShowTable>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<List<_i13.TvShowTable>>.value(<_i13.TvShowTable>[]))
          as _i6.Future<List<_i13.TvShowTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i7.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i14.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i14.Database?>.value())
          as _i6.Future<_i14.Database?>);
  @override
  _i6.Future<int> insertWatchlistMovie(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistMovie, [movie]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> insertWatchlistTvShow(_i13.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTvShow, [tvShow]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlistMovie(_i15.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistMovie, [movie]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlistTvShow(_i13.TvShowTable? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTvShow, [tvShow]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<Map<String, dynamic>?> getTvShowById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlistTvShows() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShows, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i6.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i16.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i17.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i17.Uint8List>.value(_i17.Uint8List(0)))
          as _i6.Future<_i17.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3()))
          as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}