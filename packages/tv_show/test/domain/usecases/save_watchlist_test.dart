import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvShow usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SaveWatchlistTvShow(mockTvShowRepository);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockTvShowRepository.saveWatchlist(testTvShowDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTvShowRepository.saveWatchlist(testTvShowDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
