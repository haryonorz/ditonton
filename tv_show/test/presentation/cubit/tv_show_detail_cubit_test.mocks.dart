// Mocks generated by Mockito 5.1.0 from annotations
// in tv_show/test/presentation/cubit/tv_show_detail_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_show/domain/entities/tv_show_detail.dart' as _i7;
import 'package:tv_show/domain/repositories/tv_show_repository.dart' as _i2;
import 'package:tv_show/domain/usecases/get_tv_show_detail.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvShowRepository_0 extends _i1.Fake implements _i2.TvShowRepository {
}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTvShowDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowDetail extends _i1.Mock implements _i4.GetTvShowDetail {
  MockGetTvShowDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>>.value(
              _FakeEither_1<_i6.Failure, _i7.TvShowDetail>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>>);
}
