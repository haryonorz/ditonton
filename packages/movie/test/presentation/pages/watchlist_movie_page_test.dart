import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieCubit])
void main() {
  late MockWatchlistMovieCubit mockWatchlistMovieCubit;

  setUp(() {
    mockWatchlistMovieCubit = MockWatchlistMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieCubit>(
      create: (_) => mockWatchlistMovieCubit,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieLoading()));
    when(mockWatchlistMovieCubit.state).thenReturn(WatchlistMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });
  testWidgets('Page should display text no data when empty',
      (WidgetTester tester) async {
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieEmpty()));
    when(mockWatchlistMovieCubit.state).thenReturn(WatchlistMovieEmpty());

    final textFinder = find.byKey(const Key('empty'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistMovieCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMovieHasData(<Movie>[])));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const WatchlistMovieHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieHasData(testMovieList)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(WatchlistMovieHasData(testMovieList));

    final content = find.byType(ContentCard);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(content, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockWatchlistMovieCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMovieError('Error message')));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const WatchlistMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
