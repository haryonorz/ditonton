import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'popular_movies_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesCubit popularMoviesCubit;
  late MockGetPopularMovies mockGetPopularMovies;
  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesCubit = PopularMoviesCubit(mockGetPopularMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
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

  group('popular movies', () {
    test('initial state should be empty', () {
      expect(popularMoviesCubit.state, PopularMoviesEmpty());
    });
    blocTest<PopularMoviesCubit, PopularMoviesState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        PopularMoviesLoading(),
        PopularMoviesHasData(tMovieList),
      ],
      verify: (cubit) {
        verify(mockGetPopularMovies.execute());
      },
    );
    blocTest<PopularMoviesCubit, PopularMoviesState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularMoviesCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        PopularMoviesLoading(),
        const PopularMoviesError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
