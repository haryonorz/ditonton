import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import 'popular_tv_shows_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late PopularTvShowsCubit popularTvShowsCubit;
  late MockGetPopularTvShows mockGetPopularTvShows;
  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvShowsCubit = PopularTvShowsCubit(mockGetPopularTvShows);
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

  group('popular tv shows', () {
    test('initial state should be empty', () {
      expect(popularTvShowsCubit.state, PopularTvShowsEmpty());
    });
    blocTest<PopularTvShowsCubit, PopularTvShowsState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return popularTvShowsCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        PopularTvShowsLoading(),
        PopularTvShowsHasData(tTvShowList),
      ],
      verify: (cubit) {
        verify(mockGetPopularTvShows.execute());
      },
    );
    blocTest<PopularTvShowsCubit, PopularTvShowsState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetPopularTvShows.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularTvShowsCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        PopularTvShowsLoading(),
        const PopularTvShowsError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetPopularTvShows.execute());
      },
    );
  });
}
