import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import 'top_rated_tv_shows_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late TopRatedTvShowsCubit topRatedTvShowsCubit;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;
  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    topRatedTvShowsCubit = TopRatedTvShowsCubit(mockGetTopRatedTvShows);
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

  group('top rated tv shows', () {
    test('initial state should be empty', () {
      expect(topRatedTvShowsCubit.state, TopRatedTvShowsEmpty());
    });
    blocTest<TopRatedTvShowsCubit, TopRatedTvShowsState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return topRatedTvShowsCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        TopRatedTvShowsLoading(),
        TopRatedTvShowsHasData(tTvShowList),
      ],
      verify: (cubit) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );
    blocTest<TopRatedTvShowsCubit, TopRatedTvShowsState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetTopRatedTvShows.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedTvShowsCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        TopRatedTvShowsLoading(),
        const TopRatedTvShowsError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );
  });
}
