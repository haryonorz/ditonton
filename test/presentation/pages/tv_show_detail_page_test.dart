import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/presentation/cubit/tv_show_detail/tv_show_detail_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_show_detail/tv_show_detail_state.dart';
import 'package:ditonton/presentation/cubit/tv_show_recommendations/tv_show_recommendations_cubit.dart';
import 'package:ditonton/presentation/cubit/tv_show_recommendations/tv_show_recommendations_state.dart';
import 'package:ditonton/presentation/cubit/watchlist_tv_show/watchlist_tv_show_cubit.dart';
import 'package:ditonton/presentation/cubit/watchlist_tv_show/watchlist_tv_show_state.dart';
import 'package:ditonton/presentation/pages/tv_show_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_page_test.mocks.dart';

@GenerateMocks([
  TvShowDetailCubit,
  WatchlistTvShowCubit,
  TvShowRecommendationsCubit,
])
void main() {
  late MockTvShowDetailCubit mockTvShowDetailCubit;
  late MockWatchlistTvShowCubit mockWatchlistTvShowCubit;
  late MockTvShowRecommendationsCubit mockTvShowRecommendationsCubit;

  setUp(() {
    mockTvShowDetailCubit = MockTvShowDetailCubit();
    mockWatchlistTvShowCubit = MockWatchlistTvShowCubit();
    mockTvShowRecommendationsCubit = MockTvShowRecommendationsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<TvShowDetailCubit>(
          create: (_) => mockTvShowDetailCubit,
        ),
        BlocProvider<WatchlistTvShowCubit>(
          create: (_) => mockWatchlistTvShowCubit,
        ),
        BlocProvider<TvShowRecommendationsCubit>(
          create: (_) => mockTvShowRecommendationsCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailLoading()));
    when(mockTvShowDetailCubit.state).thenReturn(TvShowDetailLoading());
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsHasData(<TvShow>[]));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailError('Error message')));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailError('Error message'));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsError('Error message')));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailHasData(testTvShowDetail)));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsHasData(<TvShow>[]));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailHasData(testTvShowDetail)));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowIsAddedToWatchlist(true)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(TvShowIsAddedToWatchlist(true));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsHasData(<TvShow>[]));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailHasData(testTvShowDetail)));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsHasData(<TvShow>[]));
    when(mockWatchlistTvShowCubit.stream).thenAnswer(
        (_) => Stream.value(WatchlistTvShowMessage('Added to Watchlist')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(WatchlistTvShowMessage('Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailHasData(testTvShowDetail)));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsHasData(<TvShow>[]));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvShowMessage('Failed')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(WatchlistTvShowMessage('Failed'));

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display Snackbar when remove from watchlist',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailHasData(testTvShowDetail)));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsHasData(<TvShow>[]));
    when(mockWatchlistTvShowCubit.stream).thenAnswer(
        (_) => Stream.value(WatchlistTvShowMessage('Removed from Watchlist')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(WatchlistTvShowMessage('Removed from Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when remove from watchlist failed',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailHasData(testTvShowDetail)));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsHasData(<TvShow>[]));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvShowMessage('Failed')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(WatchlistTvShowMessage('Failed'));

    await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
