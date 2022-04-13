import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/top_rated_movies/top_rated_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesCubit topRatedMoviesCubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesCubit = TopRatedMoviesCubit(mockGetTopRatedMovies);
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

  group('top rated movies', () {
    test('initial state should be empty', () {
      expect(topRatedMoviesCubit.state, TopRatedMoviesEmpty());
    });
    blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesHasData(tMovieList),
      ],
      verify: (cubit) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
    blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        TopRatedMoviesLoading(),
        TopRatedMoviesError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
