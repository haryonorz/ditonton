import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 100,
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "https://google.com",
    id: 1,
    imdbId: 'imdb1',
    originalLanguage: 'en',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 12000,
    runtime: 120,
    status: 'Status',
    tagline: 'Tagline',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Movie Entity', () async {
    final result = tMovieDetailResponse.toEntity();
    expect(result, tMovieDetail);
  });

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap = tMovieDetailResponse.toJson();
    // act
    final result = MovieDetailResponse.fromJson(jsonMap);
    // assert
    expect(result, tMovieDetailResponse);
  });

  test('should return a JSON map containing proper data', () async {
    // arrange

    // act
    final result = tMovieDetailResponse.toJson();
    // assert
    final expectedJsonMap = {
      "adult": false,
      "backdrop_path": 'backdropPath',
      "budget": 100,
      "genres": [
        {"id": 1, "name": 'Action'}
      ],
      "homepage": "https://google.com",
      "id": 1,
      "imdb_id": 'imdb1',
      "original_language": 'en',
      "original_title": 'originalTitle',
      "overview": 'overview',
      "popularity": 1,
      "poster_path": 'posterPath',
      "release_date": 'releaseDate',
      "revenue": 12000,
      "runtime": 120,
      "status": 'Status',
      "tagline": 'Tagline',
      "title": 'title',
      "video": false,
      "vote_average": 1,
      "vote_count": 1,
    };
    expect(result, expectedJsonMap);
  });
}
