import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_show/tv_show.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetNowPlayingTvShows(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getNowPlayingTvShows())
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvShows));
  });
}
