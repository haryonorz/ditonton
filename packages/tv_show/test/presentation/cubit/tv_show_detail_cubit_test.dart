import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvShowDetail])
void main() {
  late TvShowDetailCubit tvShowDetailCubit;
  late MockGetTvShowDetail mockGetTvShowDetail;
  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    tvShowDetailCubit = TvShowDetailCubit(mockGetTvShowDetail);
  });

  group('detail movie', () {
    test('initial state should be empty', () {
      expect(tvShowDetailCubit.state, TvShowDetailEmpty());
    });
    blocTest<TvShowDetailCubit, TvShowDetailState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvShowDetail.execute(1))
            .thenAnswer((_) async => Right(testTvShowDetail));
        return tvShowDetailCubit;
      },
      act: (cubit) => cubit.fetchData(1),
      expect: () => [
        TvShowDetailLoading(),
        TvShowDetailHasData(testTvShowDetail),
      ],
      verify: (cubit) {
        verify(mockGetTvShowDetail.execute(1));
      },
    );
    blocTest<TvShowDetailCubit, TvShowDetailState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetTvShowDetail.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvShowDetailCubit;
      },
      act: (cubit) => cubit.fetchData(1),
      expect: () => [
        TvShowDetailLoading(),
        const TvShowDetailError('Server Failure'),
      ],
      verify: (cubit) {
        verify(mockGetTvShowDetail.execute(1));
      },
    );
  });
}
