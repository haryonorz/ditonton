import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

class TvShowModel extends Equatable {
  TvShowModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  factory TvShowModel.fromJson(Map<String, dynamic> json) => TvShowModel(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "origin_country": originCountry,
        "poster_path": posterPath,
        "popularity": popularity,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvShow toEntity() {
    return TvShow(
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genreIds: this.genreIds,
      id: this.id,
      name: this.name,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        backdropPath,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}