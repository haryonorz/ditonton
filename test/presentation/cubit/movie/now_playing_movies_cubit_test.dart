import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:ditonton/presentation/cubit/now_playing_movies/now_playing_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movies_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesCubit nowPlayingMoviesCubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesCubit = NowPlayingMoviesCubit(mockGetNowPlayingMovies);
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

  group('now playing movies', () {
    test('initial state should be empty', () {
      expect(nowPlayingMoviesCubit.state, NowPlayingMoviesEmpty());
    });
    blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesHasData(tMovieList),
      ],
      verify: (cubit) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
    blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesError("Server Failure"),
      ],
      verify: (cubit) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
