import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_tv_show_page_test.mocks.dart';

@GenerateMocks([
  NowPlayingTvShowsCubit,
  PopularTvShowsCubit,
  TopRatedTvShowsCubit,
])
void main() {
  late MockNowPlayingTvShowsCubit mockNowPlayingTvShowsCubit;
  late MockPopularTvShowsCubit mockPopularTvShowsCubit;
  late MockTopRatedTvShowsCubit mockTopRatedTvShowsCubit;

  setUp(() {
    mockNowPlayingTvShowsCubit = MockNowPlayingTvShowsCubit();
    mockPopularTvShowsCubit = MockPopularTvShowsCubit();
    mockTopRatedTvShowsCubit = MockTopRatedTvShowsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<NowPlayingTvShowsCubit>(
          create: (_) => mockNowPlayingTvShowsCubit,
        ),
        BlocProvider<PopularTvShowsCubit>(
          create: (_) => mockPopularTvShowsCubit,
        ),
        BlocProvider<TopRatedTvShowsCubit>(
          create: (_) => mockTopRatedTvShowsCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNowPlayingTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(NowPlayingTvShowsLoading()));
    when(mockNowPlayingTvShowsCubit.state)
        .thenReturn(NowPlayingTvShowsLoading());
    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvShowsLoading()));
    when(mockPopularTvShowsCubit.state).thenReturn(PopularTvShowsLoading());
    when(mockTopRatedTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvShowsLoading()));
    when(mockTopRatedTvShowsCubit.state).thenReturn(TopRatedTvShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvShowPage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });
  testWidgets('Page should display text no data when empty',
      (WidgetTester tester) async {
    when(mockNowPlayingTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(NowPlayingTvShowsEmpty()));
    when(mockNowPlayingTvShowsCubit.state).thenReturn(NowPlayingTvShowsEmpty());
    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvShowsEmpty()));
    when(mockPopularTvShowsCubit.state).thenReturn(PopularTvShowsEmpty());
    when(mockTopRatedTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedTvShowsEmpty()));
    when(mockTopRatedTvShowsCubit.state).thenReturn(TopRatedTvShowsEmpty());

    final textFinder = find.byKey(const Key('empty'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvShowPage()));

    expect(centerFinder, findsWidgets);
    expect(textFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const NowPlayingTvShowsHasData(<TvShow>[])));
    when(mockNowPlayingTvShowsCubit.state)
        .thenReturn(const NowPlayingTvShowsHasData(<TvShow>[]));
    when(mockPopularTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const PopularTvShowsHasData(<TvShow>[])));
    when(mockPopularTvShowsCubit.state)
        .thenReturn(const PopularTvShowsHasData(<TvShow>[]));
    when(mockTopRatedTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedTvShowsHasData(<TvShow>[])));
    when(mockTopRatedTvShowsCubit.state)
        .thenReturn(const TopRatedTvShowsHasData(<TvShow>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvShowPage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(NowPlayingTvShowsHasData(testTvShowList)));
    when(mockNowPlayingTvShowsCubit.state)
        .thenReturn(NowPlayingTvShowsHasData(testTvShowList));
    when(mockPopularTvShowsCubit.stream)
        .thenAnswer((_) => Stream.value(PopularTvShowsHasData(testTvShowList)));
    when(mockPopularTvShowsCubit.state)
        .thenReturn(PopularTvShowsHasData(testTvShowList));
    when(mockTopRatedTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(TopRatedTvShowsHasData(testTvShowList)));
    when(mockTopRatedTvShowsCubit.state)
        .thenReturn(TopRatedTvShowsHasData(testTvShowList));

    final content = find.byType(PosterCard);

    await tester.pumpWidget(_makeTestableWidget(const HomeTvShowPage()));

    expect(content, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNowPlayingTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const NowPlayingTvShowsError('Error message')));
    when(mockNowPlayingTvShowsCubit.state)
        .thenReturn(const NowPlayingTvShowsError('Error message'));
    when(mockPopularTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const PopularTvShowsError('Error message')));
    when(mockPopularTvShowsCubit.state)
        .thenReturn(const PopularTvShowsError('Error message'));
    when(mockTopRatedTvShowsCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedTvShowsError('Error message')));
    when(mockTopRatedTvShowsCubit.state)
        .thenReturn(const TopRatedTvShowsError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const HomeTvShowPage()));

    expect(textFinder, findsWidgets);
  });
}
