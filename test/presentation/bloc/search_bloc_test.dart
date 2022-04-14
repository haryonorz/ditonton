import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/search_event.dart';
import 'package:ditonton/presentation/bloc/search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchMovieBloc searchMovieBloc;
  late SearchTvShowBloc searchTvShowBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTvShows;
  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTvShows();
    searchMovieBloc = SearchMovieBloc(mockSearchMovies);
    searchTvShowBloc = SearchTvShowBloc(mockSearchTvShows);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tTvShowModel = TvShow(
    backdropPath: '/41yaWnIT8AjIHiULHtTbKNzZTjc.jpg',
    firstAirDate: '2014-10-07',
    genreIds: [14, 28],
    id: 557,
    name: 'Spider-Man',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'The Flash',
    overview:
        "After a particle accelerator causes a freak storm, CSI Investigator Barry Allen is struck by lightning and falls into a coma. Months later he awakens with the power of super speed, granting him the ability to move through Central City like an unseen guardian angel. Though initially excited by his newfound powers, Barry is shocked to discover he is not the only \"meta-human\" who was created in the wake of the accelerator explosion -- and not everyone is using their new powers for good. Barry partners with S.T.A.R. Labs and dedicates his life to protect the innocent. For now, only a few close friends and associates know that Barry is literally the fastest man alive, but it won't be long before the world learns what Barry Allen has become...The Flash.",
    popularity: 1102.731,
    posterPath: '/lJA2RCMfsWoskqlQhXPSLFQGXEJ.jpg',
    voteAverage: 7.8,
    voteCount: 9490,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tTvShowList = <TvShow>[tTvShowModel];
  final tQueryMovie = 'spiderman';
  final tQueryTvShow = 'flash';

  group('search movies', () {
    test('initial state should be empty', () {
      expect(searchMovieBloc.state, SearchEmpty());
    });
    blocTest<SearchMovieBloc, SearchState>(
      'should emit [Loading, Empty] when no data',
      build: () {
        when(mockSearchMovies.execute(tQueryMovie))
            .thenAnswer((_) async => Right(<Movie>[]));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryMovie)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(<Movie>[]),
        SearchEmpty(),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQueryMovie));
      },
    );
    blocTest<SearchMovieBloc, SearchState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQueryMovie))
            .thenAnswer((_) async => Right(tMovieList));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryMovie)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQueryMovie));
      },
    );
    blocTest<SearchMovieBloc, SearchState>(
      'should emit [Loading, Error] when get search is unsuccessfully',
      build: () {
        when(mockSearchMovies.execute(tQueryMovie))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryMovie)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQueryMovie));
      },
    );
  });

  group('search tv shows', () {
    test('initial state should be empty', () {
      expect(searchTvShowBloc.state, SearchEmpty());
    });
    blocTest<SearchTvShowBloc, SearchState>(
      'should emit [Loading, Empty] when no data',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
            .thenAnswer((_) async => Right(<TvShow>[]));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(<TvShow>[]),
        SearchEmpty(),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );
    blocTest<SearchTvShowBloc, SearchState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
            .thenAnswer((_) async => Right(tTvShowList));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );
    blocTest<SearchTvShowBloc, SearchState>(
      'should emit [Loading, Error] when get search is unsuccessfully',
      build: () {
        when(mockSearchTvShows.execute(tQueryTvShow))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvShowBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQueryTvShow)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvShows.execute(tQueryTvShow));
      },
    );
  });
}
