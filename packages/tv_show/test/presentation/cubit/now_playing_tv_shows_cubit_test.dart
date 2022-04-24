import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import 'now_playing_tv_shows_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvShows])
void main() {
  late NowPlayingTvShowsCubit nowPlayingTvShowsCubit;
  late MockGetNowPlayingTvShows mockGetNowPlayingTvShows;
  setUp(() {
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    nowPlayingTvShowsCubit = NowPlayingTvShowsCubit(mockGetNowPlayingTvShows);
  });

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowList = <TvShow>[tTvShow];

  group('now playing movies', () {
    test('initial state should be empty', () {
      expect(nowPlayingTvShowsCubit.state, NowPlayingTvShowsEmpty());
    });
    blocTest<NowPlayingTvShowsCubit, NowPlayingTvShowsState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return nowPlayingTvShowsCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        NowPlayingTvShowsLoading(),
        NowPlayingTvShowsHasData(tTvShowList),
      ],
      verify: (cubit) {
        verify(mockGetNowPlayingTvShows.execute());
      },
    );
    blocTest<NowPlayingTvShowsCubit, NowPlayingTvShowsState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetNowPlayingTvShows.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingTvShowsCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        NowPlayingTvShowsLoading(),
        const NowPlayingTvShowsError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetNowPlayingTvShows.execute());
      },
    );
  });
}
