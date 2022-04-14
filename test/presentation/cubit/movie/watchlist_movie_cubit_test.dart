import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist_movie.dart';
import 'package:ditonton/presentation/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_movie/watchlist_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatusMovie,
  SaveWatchlistMovie,
  RemoveWatchlistMovie
])
void main() {
  late WatchlistMovieCubit watchlistMovieCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatusMovie mockGetWatchListStatusMovie;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;
  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatusMovie = MockGetWatchListStatusMovie();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    watchlistMovieCubit = WatchlistMovieCubit(
      mockGetWatchlistMovies,
      mockGetWatchListStatusMovie,
      mockSaveWatchlistMovie,
      mockRemoveWatchlistMovie,
    );
  });

  group('watchlist movies', () {
    test('initial state should be empty', () {
      expect(watchlistMovieCubit.state, WatchlistMovieEmpty());
    });
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData([testWatchlistMovie]),
      ],
      verify: (cubit) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'should emit [Loading, Error] when get watchlist is unsuccessfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError("Can't get data"),
      ],
      verify: (cubit) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'should emit [true] when watchlist status is true',
      build: () {
        when(mockGetWatchListStatusMovie.execute(1))
            .thenAnswer((_) async => true);
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.loadWatchlistStatus(1),
      expect: () => [
        MovieIsAddedToWatchlist(true),
      ],
      verify: (cubit) {
        verify(mockGetWatchListStatusMovie.execute(1));
      },
    );
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'should emit [message, true] when save watchlist succeeded ',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
        return watchlistMovieCubit;
      },
      act: (cubit) {
        cubit.addToWatchlist(testMovieDetail);
      },
      expect: () => [
        WatchlistMovieMessage(watchlistAddSuccessMessage),
      ],
      verify: (cubit) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
      },
    );
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'should emit [message, true] when save watchlist failed ',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure("Can't input data")));
        return watchlistMovieCubit;
      },
      act: (cubit) {
        cubit.addToWatchlist(testMovieDetail);
      },
      expect: () => [
        WatchlistMovieMessage("Can't input data"),
      ],
      verify: (cubit) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
      },
    );
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'should emit [message, false] when remove watchlist succeeded',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
        return watchlistMovieCubit;
      },
      act: (cubit) {
        cubit.removeFromWatchlist(testMovieDetail);
      },
      expect: () => [
        WatchlistMovieMessage(watchlistAddSuccessMessage),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
      },
    );
  });
  blocTest<WatchlistMovieCubit, WatchlistMovieState>(
    'should emit [message, true] when remove watchlist failed ',
    build: () {
      when(mockRemoveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure("Can't delete data")));
      return watchlistMovieCubit;
    },
    act: (cubit) {
      cubit.removeFromWatchlist(testMovieDetail);
    },
    expect: () => [
      WatchlistMovieMessage("Can't delete data"),
    ],
    verify: (cubit) {
      verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
    },
  );
}
