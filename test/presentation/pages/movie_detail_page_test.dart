import 'package:ditonton/presentation/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/movie_detail/movie_detail_state.dart';
import 'package:ditonton/presentation/cubit/movie_recommendations/movie_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_movie/watchlist_movie_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
        BlocProvider<MockWatchlistMovieCubit>(
          create: (_) => mockWatchlistMovieCubit,
        ),
        BlocProvider<MockMovieRecommendationsCubit>(
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
        .thenAnswer((_) => Stream.value(MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(MovieIsAddedToWatchlist(false));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailError('Error message')));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(MovieIsAddedToWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(MovieIsAddedToWatchlist(true)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(MovieIsAddedToWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(MovieIsAddedToWatchlist(false));
    when(mockWatchlistMovieCubit.stream).thenAnswer(
        (_) => Stream.value(WatchlistMovieMessage('Added to Watchlist')));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(WatchlistMovieMessage('Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream)
        .thenAnswer((_) => Stream.value(MovieDetailHasData(testMovieDetail)));
    when(mockMovieDetailCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(MovieIsAddedToWatchlist(false)));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(MovieIsAddedToWatchlist(false));
    when(mockWatchlistMovieCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieMessage('Failed')));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(WatchlistMovieMessage('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
