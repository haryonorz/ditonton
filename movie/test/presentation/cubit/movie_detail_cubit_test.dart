import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;
  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailCubit = MovieDetailCubit(mockGetMovieDetail);
  });

  group('detail movie', () {
    test('initial state should be empty', () {
      expect(movieDetailCubit.state, MovieDetailEmpty());
    });
    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return movieDetailCubit;
      },
      act: (cubit) => cubit.fetchData(1),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailHasData(testMovieDetail),
      ],
      verify: (cubit) {
        verify(mockGetMovieDetail.execute(1));
      },
    );
    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [Loading, Error] when get data is unsuccessfully',
      build: () {
        when(mockGetMovieDetail.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailCubit;
      },
      act: (cubit) => cubit.fetchData(1),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailError('Server Failure'),
      ],
      verify: (cubit) {
        verify(mockGetMovieDetail.execute(1));
      },
    );
  });
}
