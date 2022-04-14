import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/cubit/movie_recommendations/movie_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/movie_recommendations/movie_recommendations_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendations_cubit_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsCubit movieRecommendationsCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsCubit =
        MovieRecommendationsCubit(mockGetMovieRecommendations);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  group('recommendation movies', () {
    test('initial state should be empty', () {
      expect(movieRecommendationsCubit.state, MovieRecommendationsEmpty());
    });
    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(tMovieList));
        return movieRecommendationsCubit;
      },
      act: (cubit) => cubit.fetchData(1),
      expect: () => [
        MovieRecommendationsLoading(),
        MovieRecommendationsHasData(tMovieList),
      ],
      verify: (cubit) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );
    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieRecommendationsCubit;
      },
      act: (cubit) => cubit.fetchData(1),
      expect: () => [
        MovieRecommendationsLoading(),
        MovieRecommendationsError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );
  });
}
