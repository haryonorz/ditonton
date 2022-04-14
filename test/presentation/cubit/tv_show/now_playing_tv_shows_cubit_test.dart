import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:ditonton/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/now_playing_tv_shows/now_playing_tv_shows_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
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
        when(mockGetNowPlayingTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingTvShowsCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        NowPlayingTvShowsLoading(),
        NowPlayingTvShowsError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetNowPlayingTvShows.execute());
      },
    );
  });
}
