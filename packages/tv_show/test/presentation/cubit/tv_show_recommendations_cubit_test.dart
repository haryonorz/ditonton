import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import 'tv_show_recommendations_cubit_test.mocks.dart';

@GenerateMocks([GetTvShowRecommendations])
void main() {
  late TvShowRecommendationsCubit tvShowRecommendationsCubit;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  setUp(() {
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    tvShowRecommendationsCubit =
        TvShowRecommendationsCubit(mockGetTvShowRecommendations);
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

  group('recommendation tv shows', () {
    test('initial state should be empty', () {
      expect(tvShowRecommendationsCubit.state, TvShowRecommendationsEmpty());
    });
    blocTest<TvShowRecommendationsCubit, TvShowRecommendationsState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvShowRecommendations.execute(1))
            .thenAnswer((_) async => Right(tTvShowList));
        return tvShowRecommendationsCubit;
      },
      act: (cubit) => cubit.fetchData(1),
      expect: () => [
        TvShowRecommendationsLoading(),
        TvShowRecommendationsHasData(tTvShowList),
      ],
      verify: (cubit) {
        verify(mockGetTvShowRecommendations.execute(1));
      },
    );
    blocTest<TvShowRecommendationsCubit, TvShowRecommendationsState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetTvShowRecommendations.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvShowRecommendationsCubit;
      },
      act: (cubit) => cubit.fetchData(1),
      expect: () => [
        TvShowRecommendationsLoading(),
        const TvShowRecommendationsError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetTvShowRecommendations.execute(1));
      },
    );
  });
}
