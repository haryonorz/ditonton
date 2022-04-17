import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_page_test.mocks.dart';

@GenerateMocks([WatchlistTvShowCubit])
void main() {
  late MockWatchlistTvShowCubit mockWatchlistTvShowCubit;

  setUp(() {
    mockWatchlistTvShowCubit = MockWatchlistTvShowCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvShowCubit>(
      create: (_) => mockWatchlistTvShowCubit,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvShowLoading()));
    when(mockWatchlistTvShowCubit.state).thenReturn(WatchlistTvShowLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });
  testWidgets('Page should display text no data when empty',
      (WidgetTester tester) async {
    when(mockWatchlistTvShowCubit.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvShowEmpty()));
    when(mockWatchlistTvShowCubit.state).thenReturn(WatchlistTvShowEmpty());

    final textFinder = find.byKey(const Key('empty'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistTvShowCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistTvShowHasData(<TvShow>[])));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const WatchlistTvShowHasData(<TvShow>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistTvShowCubit.stream).thenAnswer(
        (_) => Stream.value(WatchlistTvShowHasData(testTvShowList)));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(WatchlistTvShowHasData(testTvShowList));

    final content = find.byType(ContentCard);

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(content, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockWatchlistTvShowCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistTvShowError('Error message')));
    when(mockWatchlistTvShowCubit.state)
        .thenReturn(const WatchlistTvShowError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const WatchlistTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
