import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([
  MovieDetailCubit,
  WatchlistMovieCubit,
  MovieRecommendationsCubit,
])
void main() {
  late MockMovieDetailCubit mockMovieDetailCubit;
  late MockWatchlistMovieCubit mockWatchlistMovieCubit;
  late MockMovieRecommendationsCubit mockMovieRecommendationsCubit;

  setUp(() {
    mockMovieDetailCubit = MockMovieDetailCubit();
    mockWatchlistMovieCubit = MockWatchlistMovieCubit();
    mockMovieRecommendationsCubit = MockMovieRecommendationsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailCubit>(
          create: (_) => mockMovieDetailCubit,
        ),
        BlocProvider<WatchlistMovieCubit>(
          create: (_) => mockWatchlistMovieCubit,
        ),
        BlocProvider<MovieRecommendationsCubit>(
          create: (_) => mockMovieRecommendationsCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailLoading()));
    when(mockMovieDetailCubit.state).thenReturn(MovieDetailLoading());
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(false));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsHasData(<Movie>[])));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsHasData(<Movie>[]));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailError('Error message')));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailError('Error message'));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(false));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsError('Error message')));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(false));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsHasData(<Movie>[])));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsHasData(<Movie>[]));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(true)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(true));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsHasData(<Movie>[])));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsHasData(<Movie>[]));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(false));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsHasData(<Movie>[])));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsHasData(<Movie>[]));
    when(mockWatchlistMovieCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMovieMessage('Added to Watchlist')));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const WatchlistMovieMessage('Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(false));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsHasData(<Movie>[])));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsHasData(<Movie>[]));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistMovieMessage('Failed')));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const WatchlistMovieMessage('Failed'));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when remove from watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(true)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(true));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsHasData(<Movie>[])));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsHasData(<Movie>[]));
    when(mockWatchlistMovieCubit.stream).thenAnswer((_) =>
        Stream.value(const WatchlistMovieMessage('Removed from Watchlist')));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const WatchlistMovieMessage('Removed from Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when remove from watchlist failed',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(true)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(true));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsHasData(<Movie>[])));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsHasData(<Movie>[]));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistMovieMessage('Failed')));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const WatchlistMovieMessage('Failed'));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
  testWidgets(
      'Page should display recommendation ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(false));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(MovieRecommendationsHasData(testMovieList)));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(MovieRecommendationsHasData(testMovieList));

    final contentFinder = find.byKey(const Key('recommendation_item'));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(contentFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when recommendation movie Error',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(const MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const MovieIsAddedToWatchlist(false));
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsError('Error message')));
    when(mockMovieRecommendationsCubit.state)
        .thenReturn(const MovieRecommendationsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });
}
