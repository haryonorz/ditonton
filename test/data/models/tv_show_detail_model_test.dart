import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowDetailResponse = TvShowDetailResponse(
    backdropPath: 'backdropPath',
    episodeRunTime: [1],
    firstAirDate: 'firstAirDate',
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    languages: ['us'],
    lastAirDate: 'lastAirDate',
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: 'originalName',
    originalLanguage: 'originalLanguage',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    seasons: [
      SeasonModel(
        airDate: "2020-05-05",
        episodeCount: 1,
        id: 1,
        name: 'Name',
        overview: 'Overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      )
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowDetail = TvShowDetail(
    backdropPath: 'backdropPath',
    episodeRunTime: [1],
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    seasons: [
      Season(
        airDate: "2020-05-05",
        episodeCount: 1,
        id: 1,
        name: 'Name',
        overview: 'Overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      )
    ],
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of TvShowDetail Entity', () async {
    final result = tTvShowDetailResponse.toEntity();
    expect(result, tTvShowDetail);
  });

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap = tTvShowDetailResponse.toJson();
    // act
    final result = TvShowDetailResponse.fromJson(jsonMap);
    // assert
    expect(result, tTvShowDetailResponse);
  });

  test('should return a JSON map containing proper data', () async {
    // arrange

    // act
    final result = tTvShowDetailResponse.toJson();
    // assert
    final expectedJsonMap = {
      "backdrop_path": 'backdropPath',
      "episode_run_time": [1],
      "first_air_date": 'firstAirDate',
      "genres": [
        {"id": 1, "name": 'Action'}
      ],
      "homepage": 'homepage',
      "id": 1,
      "in_production": false,
      "languages": ['us'],
      "last_air_date": 'lastAirDate',
      "name": 'name',
      "number_of_episodes": 1,
      "number_of_seasons": 1,
      "original_name": 'originalName',
      "original_language": 'originalLanguage',
      "overview": 'overview',
      "popularity": 1,
      "poster_path": 'posterPath',
      "seasons": [
        {
          "air_date": "2020-05-05",
          "episode_count": 1,
          "id": 1,
          "name": 'Name',
          "overview": 'Overview',
          "poster_path": 'posterPath',
          "season_number": 1,
        }
      ],
      "status": 'status',
      "tagline": 'tagline',
      "type": 'type',
      "vote_average": 1,
      "vote_count": 1,
    };
    expect(result, expectedJsonMap);
  });
}
