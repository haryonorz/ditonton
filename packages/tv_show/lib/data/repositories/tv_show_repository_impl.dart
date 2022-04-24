import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_show/data/datasources/tv_show_local_data_source.dart';
import 'package:tv_show/data/datasources/tv_show_remote_data_source.dart';
import 'package:tv_show/data/models/tv_show_table.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';
import 'package:tv_show/domain/repositories/tv_show_repository.dart';

class TvShowRepositoryImpl implements TvShowRepository {
  final TvShowRemoteDataSource remoteDataSource;
  final TvShowLocalDataSource localDataSource;

  TvShowRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvShow>>> getNowPlayingTvShows() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvShowDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvShowRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTvShows() async {
    try {
      final result = await remoteDataSource.getPopularTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows() async {
    try {
      final result = await remoteDataSource.getTopRatedTvShows();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query) async {
    try {
      final result = await remoteDataSource.searchTvShows(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvShowDetail tvShow) async {
    try {
      final result =
          await localDataSource.insertWatchlist(TvShowTable.fromEntity(tvShow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvShowDetail tvShow) async {
    try {
      final result =
          await localDataSource.removeWatchlist(TvShowTable.fromEntity(tvShow));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvShowById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows() async {
    final result = await localDataSource.getWatchlistTvShows();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
