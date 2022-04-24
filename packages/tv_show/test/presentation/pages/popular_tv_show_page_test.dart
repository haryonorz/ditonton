import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_show_page_test.mocks.dart';

@GenerateMocks([PopularTvShowsCubit])
void main() {
  late MockPopularTvShowsCubit mockPopularTvShowsCubit;

  setUp(() {
    mockPopularTvShowsCubit = MockPopularTvShowsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvShowsCubit>(
      create: (_) => mockPopularTvShowsCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvShowsLoading()));
    when(mockPopularTvShowsCubit.state).thenReturn(PopularTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });
  testWidgets('Page should display text no data when empty',
      (WidgetTester tester) async {
    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvShowsEmpty()));
    when(mockPopularTvShowsCubit.state).thenReturn(PopularTvShowsEmpty());

    final textFinder = find.byKey(const Key('empty'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const PopularTvShowsHasData(<TvShow>[])));
    when(mockPopularTvShowsCubit.state)
        .thenReturn(const PopularTvShowsHasData(<TvShow>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvShowsHasData(testTvShowList)));
    when(mockPopularTvShowsCubit.state)
        .thenReturn(PopularTvShowsHasData(testTvShowList));

    final content = find.byType(ContentCard);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(content, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockPopularTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const PopularTvShowsError('Error message')));
    when(mockPopularTvShowsCubit.state)
        .thenReturn(const PopularTvShowsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
