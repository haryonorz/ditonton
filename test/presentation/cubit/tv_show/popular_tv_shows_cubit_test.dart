import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:ditonton/presentation/cubit/popular_tv_shows/popular_tv_shows_cubit.dart';
import 'package:ditonton/presentation/cubit/popular_tv_shows/popular_tv_shows_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvShowsCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        PopularTvShowsLoading(),
        PopularTvShowsError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetPopularTvShows.execute());
      },
    );
  });
}
