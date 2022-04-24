import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_show_page_test.mocks.dart';

@GenerateMocks([TopRatedTvShowsCubit])
void main() {
  late MockTopRatedTvShowsCubit mockTopRatedTvShowsCubit;

  setUp(() {
    mockTopRatedTvShowsCubit = MockTopRatedTvShowsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvShowsCubit>(
      create: (_) => mockTopRatedTvShowsCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvShowsLoading()));
    when(mockTopRatedTvShowsCubit.state).thenReturn(TopRatedTvShowsLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });
  testWidgets('Page should display text no data when empty',
      (WidgetTester tester) async {
    when(mockTopRatedTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvShowsEmpty()));
    when(mockTopRatedTvShowsCubit.state).thenReturn(TopRatedTvShowsEmpty());

    final textFinder = find.byKey(const Key('empty'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedTvShowsHasData(<TvShow>[])));
    when(mockTopRatedTvShowsCubit.state)
        .thenReturn(const TopRatedTvShowsHasData(<TvShow>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(TopRatedTvShowsHasData(testTvShowList)));
    when(mockTopRatedTvShowsCubit.state)
        .thenReturn(TopRatedTvShowsHasData(testTvShowList));

    final content = find.byType(ContentCard);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(content, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTopRatedTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedTvShowsError('Error message')));
    when(mockTopRatedTvShowsCubit.state)
        .thenReturn(const TopRatedTvShowsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
