import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_show_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvShows,
  GetWatchlistStatusTvShow,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow
])
void main() {
  late WatchlistTvShowCubit watchlistTvShowCubit;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;
  late MockGetWatchlistStatusTvShow mockGetWatchlistStatusTvShow;
  late MockSaveWatchlistTvShow mockSaveWatchlistTvShow;
  late MockRemoveWatchlistTvShow mockRemoveWatchlistTvShow;
  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    mockGetWatchlistStatusTvShow = MockGetWatchlistStatusTvShow();
    mockSaveWatchlistTvShow = MockSaveWatchlistTvShow();
    mockRemoveWatchlistTvShow = MockRemoveWatchlistTvShow();
    watchlistTvShowCubit = WatchlistTvShowCubit(
      mockGetWatchlistTvShows,
      mockGetWatchlistStatusTvShow,
      mockSaveWatchlistTvShow,
      mockRemoveWatchlistTvShow,
    );
  });

  group('watchlist tv shows', () {
    test('initial state should be empty', () {
      expect(watchlistTvShowCubit.state, WatchlistTvShowEmpty());
    });
    blocTest<WatchlistTvShowCubit, WatchlistTvShowState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvShows.execute())
            .thenAnswer((_) async => Right([testWatchlistTvShow]));
        return watchlistTvShowCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        WatchlistTvShowLoading(),
        WatchlistTvShowHasData([testWatchlistTvShow]),
      ],
      verify: (cubit) {
        verify(mockGetWatchlistTvShows.execute());
      },
    );
    blocTest<WatchlistTvShowCubit, WatchlistTvShowState>(
      'should emit [Loading, Error] when get watchlist is unsuccessfully',
      build: () {
        when(mockGetWatchlistTvShows.execute()).thenAnswer(
            (_) async => const Left(DatabaseFailure("Can't get data")));
        return watchlistTvShowCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        WatchlistTvShowLoading(),
        const WatchlistTvShowError("Can't get data"),
      ],
      verify: (cubit) {
        verify(mockGetWatchlistTvShows.execute());
      },
    );
    blocTest<WatchlistTvShowCubit, WatchlistTvShowState>(
      'should emit [true] when watchlist status is true',
      build: () {
        when(mockGetWatchlistStatusTvShow.execute(1))
            .thenAnswer((_) async => true);
        return watchlistTvShowCubit;
      },
      act: (cubit) => cubit.loadWatchlistStatus(1),
      expect: () => [
        const TvShowIsAddedToWatchlist(true),
      ],
      verify: (cubit) {
        verify(mockGetWatchlistStatusTvShow.execute(1));
      },
    );
    blocTest<WatchlistTvShowCubit, WatchlistTvShowState>(
      'should emit [message, true] when save watchlist succeeded',
      build: () {
        when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return watchlistTvShowCubit;
      },
      act: (cubit) {
        cubit.addToWatchlist(testTvShowDetail);
      },
      expect: () => [
        const WatchlistTvShowMessage(watchlistAddSuccessMessage),
      ],
      verify: (cubit) {
        verify(mockSaveWatchlistTvShow.execute(testTvShowDetail));
      },
    );
    blocTest<WatchlistTvShowCubit, WatchlistTvShowState>(
      'should emit [message, true] when save watchlist failed ',
      build: () {
        when(mockSaveWatchlistTvShow.execute(testTvShowDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure("Can't input data")));
        return watchlistTvShowCubit;
      },
      act: (cubit) {
        cubit.addToWatchlist(testTvShowDetail);
      },
      expect: () => [
        const WatchlistTvShowMessage("Can't input data"),
      ],
      verify: (cubit) {
        verify(mockSaveWatchlistTvShow.execute(testTvShowDetail));
      },
    );
    blocTest<WatchlistTvShowCubit, WatchlistTvShowState>(
      'should emit [message, false] when remove watchlist succeeded',
      build: () {
        when(mockRemoveWatchlistTvShow.execute(testTvShowDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return watchlistTvShowCubit;
      },
      act: (cubit) {
        cubit.removeFromWatchlist(testTvShowDetail);
      },
      expect: () => [
        const WatchlistTvShowMessage(watchlistAddSuccessMessage),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlistTvShow.execute(testTvShowDetail));
      },
    );
    blocTest<WatchlistTvShowCubit, WatchlistTvShowState>(
      'should emit [message, true] when remove watchlist failed ',
      build: () {
        when(mockRemoveWatchlistTvShow.execute(testTvShowDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure("Can't delete data")));
        return watchlistTvShowCubit;
      },
      act: (cubit) {
        cubit.removeFromWatchlist(testTvShowDetail);
      },
      expect: () => [
        const WatchlistTvShowMessage("Can't delete data"),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlistTvShow.execute(testTvShowDetail));
      },
    );
  });
}
