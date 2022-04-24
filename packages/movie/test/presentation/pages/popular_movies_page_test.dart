import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesCubit])
void main() {
  late MockPopularMoviesCubit mockPopularMoviesCubit;

  setUp(() {
    mockPopularMoviesCubit = MockPopularMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesCubit>(
      create: (_) => mockPopularMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesLoading()));
    when(mockPopularMoviesCubit.state).thenReturn(PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text no data when empty',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesEmpty()));
    when(mockPopularMoviesCubit.state).thenReturn(PopularMoviesEmpty());

    final textFinder = find.byKey(const Key('empty'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(const PopularMoviesHasData(<Movie>[])));
    when(mockPopularMoviesCubit.state)
        .thenReturn(const PopularMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesHasData(testMovieList)));
    when(mockPopularMoviesCubit.state)
        .thenReturn(PopularMoviesHasData(testMovieList));

    final content = find.byType(ContentCard);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(content, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockPopularMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(const PopularMoviesError('Error message')));
    when(mockPopularMoviesCubit.state)
        .thenReturn(const PopularMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
