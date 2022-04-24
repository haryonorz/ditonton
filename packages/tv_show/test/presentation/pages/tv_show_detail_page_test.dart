import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_show/tv_show.dart';

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
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsHasData(<TvShow>[]));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowDetailError('Error message')));
    when(mockTvShowDetailCubit.state)
        .thenReturn(const TvShowDetailError('Error message'));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsError('Error message')));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

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
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsHasData(<TvShow>[]));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

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
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(true)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(true));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsHasData(<TvShow>[]));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

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
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsHasData(<TvShow>[]));
    when(mockWatchlistTvShowCubit.stream).thenAnswer((_) =>
        Stream.value(const WatchlistTvShowMessage('Added to Watchlist')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const WatchlistTvShowMessage('Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

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
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsHasData(<TvShow>[]));
    when(mockWatchlistTvShowCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistTvShowMessage('Failed')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const WatchlistTvShowMessage('Failed'));

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

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
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsHasData(<TvShow>[]));
    when(mockWatchlistTvShowCubit.stream).thenAnswer((_) =>
        Stream.value(const WatchlistTvShowMessage('Removed from Watchlist')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const WatchlistTvShowMessage('Removed from Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

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
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsHasData(<TvShow>[])));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsHasData(<TvShow>[]));
    when(mockWatchlistTvShowCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistTvShowMessage('Failed')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const WatchlistTvShowMessage('Failed'));

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
  testWidgets(
      'Page should display recommendation ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailHasData(testTvShowDetail)));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(TvShowRecommendationsHasData(testTvShowList)));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(TvShowRecommendationsHasData(testTvShowList));

    final contentFinder = find.byKey(const Key('recommendation_item'));

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

    expect(contentFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display text with message when recommendation movie Error',
      (WidgetTester tester) async {
    when(mockTvShowDetailCubit.stream)
        .thenAnswer((_) => Stream.value(TvShowDetailHasData(testTvShowDetail)));
    when(mockTvShowDetailCubit.state)
        .thenReturn(TvShowDetailHasData(testTvShowDetail));
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(const TvShowIsAddedToWatchlist(false)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const TvShowIsAddedToWatchlist(false));
    when(mockTvShowRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvShowRecommendationsError('Error message')));
    when(mockTvShowRecommendationsCubit.state)
        .thenReturn(const TvShowRecommendationsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });
}
