import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/search.dart';
import 'package:provider/provider.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

import 'search_page_test.mocks.dart';

@GenerateMocks([SearchMovieBloc, SearchTvShowBloc, MenuCubit])
void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;
  late MockSearchTvShowBloc mockSearchTvShowBloc;
  late MockMenuCubit mockMenuCubit;

  setUp(() {
    mockSearchMovieBloc = MockSearchMovieBloc();
    mockSearchTvShowBloc = MockSearchTvShowBloc();
    mockMenuCubit = MockMenuCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<SearchMovieBloc>(
          create: (_) => mockSearchMovieBloc,
        ),
        BlocProvider<SearchTvShowBloc>(
          create: (_) => mockSearchTvShowBloc,
        ),
        BlocProvider<MenuCubit>(
          create: (_) => mockMenuCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
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
    genreIds: const [14, 28],
    id: 557,
    name: 'Spider-Man',
    originCountry: const ['US'],
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
  const tQueryMovie = 'spiderman';
  const tQueryTvShow = 'flash';

  group('search movie', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockMenuCubit.stream)
          .thenAnswer((_) => Stream.value(MenuItem.movie));
      when(mockMenuCubit.state).thenReturn(MenuItem.movie);
      when(mockSearchMovieBloc.stream)
          .thenAnswer((_) => Stream.value(SearchLoading()));
      when(mockSearchMovieBloc.state).thenReturn(SearchLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsOneWidget);
    });
    testWidgets('Page should display text no data when empty',
        (WidgetTester tester) async {
      when(mockMenuCubit.stream)
          .thenAnswer((_) => Stream.value(MenuItem.movie));
      when(mockMenuCubit.state).thenReturn(MenuItem.movie);
      when(mockSearchMovieBloc.stream)
          .thenAnswer((_) => Stream.value(SearchEmpty()));
      when(mockSearchMovieBloc.state).thenReturn(SearchEmpty());

      final textFinder = find.byKey(const Key('empty'));

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView Item when query typed',
        (WidgetTester tester) async {
      when(mockMenuCubit.stream)
          .thenAnswer((_) => Stream.value(MenuItem.movie));
      when(mockMenuCubit.state).thenReturn(MenuItem.movie);
      when(mockSearchMovieBloc.stream)
          .thenAnswer((_) => Stream.value(SearchHasData(tMovieList)));
      when(mockSearchMovieBloc.state).thenReturn(SearchHasData(tMovieList));

      final textfieldFinder = find.byKey(const Key('query_input'));

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));
      await tester.enterText(textfieldFinder, tQueryMovie);
      await tester.testTextInput.receiveAction(TextInputAction.done);

      verify(mockSearchMovieBloc.add(const OnQueryChanged(tQueryMovie)));
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockMenuCubit.stream)
          .thenAnswer((_) => Stream.value(MenuItem.movie));
      when(mockMenuCubit.state).thenReturn(MenuItem.movie);
      when(mockSearchMovieBloc.stream)
          .thenAnswer((_) => Stream.value(const SearchError('Error message')));
      when(mockSearchMovieBloc.state)
          .thenReturn(const SearchError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(textFinder, findsOneWidget);
    });
  });

  group('search tv show', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockMenuCubit.stream)
          .thenAnswer((_) => Stream.value(MenuItem.tvShow));
      when(mockMenuCubit.state).thenReturn(MenuItem.tvShow);
      when(mockSearchTvShowBloc.stream)
          .thenAnswer((_) => Stream.value(SearchLoading()));
      when(mockSearchTvShowBloc.state).thenReturn(SearchLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(centerFinder, findsWidgets);
      expect(progressBarFinder, findsOneWidget);
    });
    testWidgets('Page should display text no data when empty',
        (WidgetTester tester) async {
      when(mockMenuCubit.stream)
          .thenAnswer((_) => Stream.value(MenuItem.tvShow));
      when(mockMenuCubit.state).thenReturn(MenuItem.tvShow);
      when(mockSearchTvShowBloc.stream)
          .thenAnswer((_) => Stream.value(SearchEmpty()));
      when(mockSearchTvShowBloc.state).thenReturn(SearchEmpty());

      final textFinder = find.byKey(const Key('empty'));

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView Item when query typed',
        (WidgetTester tester) async {
      when(mockMenuCubit.stream)
          .thenAnswer((_) => Stream.value(MenuItem.tvShow));
      when(mockMenuCubit.state).thenReturn(MenuItem.tvShow);
      when(mockSearchTvShowBloc.stream)
          .thenAnswer((_) => Stream.value(SearchHasData(tTvShowList)));
      when(mockSearchTvShowBloc.state).thenReturn(SearchHasData(tTvShowList));

      final textfieldFinder = find.byKey(const Key('query_input'));

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));
      await tester.enterText(textfieldFinder, tQueryTvShow);
      await tester.testTextInput.receiveAction(TextInputAction.done);

      verify(mockSearchTvShowBloc.add(const OnQueryChanged(tQueryTvShow)));
    });

    testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockMenuCubit.stream)
          .thenAnswer((_) => Stream.value(MenuItem.tvShow));
      when(mockMenuCubit.state).thenReturn(MenuItem.tvShow);
      when(mockSearchTvShowBloc.stream)
          .thenAnswer((_) => Stream.value(const SearchError('Error message')));
      when(mockSearchTvShowBloc.state)
          .thenReturn(const SearchError('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
