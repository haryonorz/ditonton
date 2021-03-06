import 'package:core/presentation/widgets/content_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesCubit])
void main() {
  late MockTopRatedMoviesCubit mockTopRatedMoviesCubit;

  setUp(() {
    mockTopRatedMoviesCubit = MockTopRatedMoviesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesCubit>(
      create: (_) => mockTopRatedMoviesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesLoading()));
    when(mockTopRatedMoviesCubit.state).thenReturn(TopRatedMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display text no data when empty',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesEmpty()));
    when(mockTopRatedMoviesCubit.state).thenReturn(TopRatedMoviesEmpty());

    final textFinder = find.byKey(const Key('empty'));
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedMoviesHasData(<Movie>[])));
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(const TopRatedMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView Item when data is loaded',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesHasData(testMovieList)));
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    final content = find.byType(ContentCard);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(content, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockTopRatedMoviesCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedMoviesError('Error message')));
    when(mockTopRatedMoviesCubit.state)
        .thenReturn(const TopRatedMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
