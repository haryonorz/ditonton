import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_page_test.mocks.dart';

@GenerateMocks([
  NowPlayingMoviesCubit,
  PopularMoviesCubit,
  TopRatedMoviesCubit,
])
void main() {
  late MockNowPlayingMoviesCubit mockNowPlayingMoviesCubit;
  late MockPopularMoviesCubit mockPopularMoviesCubit;
  late MockTopRatedMoviesCubit mockTopRatedMoviesCubit;

  setUp(() {
    mockNowPlayingMoviesCubit = MockNowPlayingMoviesCubit();
    mockPopularMoviesCubit = MockPopularMoviesCubit();
    mockTopRatedMoviesCubit = MockTopRatedMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<NowPlayingMoviesCubit>(
          create: (_) => mockNowPlayingMoviesCubit,
        ),
        BlocProvider<PopularMoviesCubit>(
          create: (_) => mockPopularMoviesCubit,
        ),
        BlocProvider<TopRatedMoviesCubit>(
          create: (_) => mockTopRatedMoviesCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNowPlayingMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(NowPlayingMoviesLoading()));
    when(mockNowPlayingMoviesCubit.state).thenReturn(NowPlayingMoviesLoading());
    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesLoading()));
    when(mockPopularMoviesCubit.state).thenReturn(PopularMoviesLoading());
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesLoading()));
    when(mockTopRatedMoviesCubit.state).thenReturn(TopRatedMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(centerFinder, findsWidgets);
    expect(progressBarFinder, findsWidgets);
  });
  testWidgets('Page should display text no data when empty',
      (WidgetTester tester) async {
    when(mockNowPlayingMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(NowPlayingMoviesEmpty()));
    when(mockNowPlayingMoviesCubit.state).thenReturn(NowPlayingMoviesEmpty());
    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesEmpty()));
    when(mockPopularMoviesCubit.state).thenReturn(PopularMoviesEmpty());
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesEmpty()));
    when(mockTopRatedMoviesCubit.state).thenReturn(TopRatedMoviesEmpty());

    final textFinder = find.byKey(const Key('empty'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(centerFinder, findsWidgets);
    expect(textFinder, findsWidgets);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(const NowPlayingMoviesHasData(<Movie>[])));
    when(mockNowPlayingMoviesCubit.state)
        .thenReturn(const NowPlayingMoviesHasData(<Movie>[]));
    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(const PopularMoviesHasData(<Movie>[])));
    when(mockPopularMoviesCubit.state)
        .thenReturn(const PopularMoviesHasData(<Movie>[]));
    when(mockTopRatedMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedMoviesHasData(<Movie>[])));
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(const TopRatedMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });

  testWidgets('Page should display ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(NowPlayingMoviesHasData(testMovieList)));
    when(mockNowPlayingMoviesCubit.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesHasData(testMovieList)));
    when(mockPopularMoviesCubit.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesHasData(testMovieList)));
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    final content = find.byType(PosterCard);

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(content, findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNowPlayingMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(const NowPlayingMoviesError('Error message')));
    when(mockNowPlayingMoviesCubit.state)
        .thenReturn(const NowPlayingMoviesError('Error message'));
    when(mockPopularMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(const PopularMoviesError('Error message')));
    when(mockPopularMoviesCubit.state)
        .thenReturn(const PopularMoviesError('Error message'));
    when(mockTopRatedMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedMoviesError('Error message')));
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(const TopRatedMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const HomeMoviePage()));

    expect(textFinder, findsWidgets);
  });
}
