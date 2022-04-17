import 'package:core/domain/entities/genre.dart';
import 'package:tv_show/tv_show.dart';

final testTvShow = TvShow(
  backdropPath: '/41yaWnIT8AjIHiULHtTbKNzZTjc.jpg',
  firstAirDate: '2014-10-07',
  genreIds: const [14, 28],
  id: 557,
  name: 'Spider-Man',
  originCountry: const ['US'],
  originalLanguage: 'en',
  originalName: 'The Flash',
  overview:
      "After a particle accelerator causes a freak storm, CSI Investigator Barry Allen is struck by lightning and falls into a coma. Months later he awakens with the power of super speed, granting him the ability to move through Central City like an unseen guardian angel. Though initially excited by his newfound powers, Barry is shocked to discover he is not the only \"meta-human\" who was created in the wake of the accelerator explosion -- and not everyone is using their new powers for good. Barry partners with S.T.A.R. Labs and dedicates his life to protect the innocent. For now, only a few close friends and associates know that Barry is literally the fastest man alive, but it won't be long before the world learns what Barry Allen has become...The Flash.",
  popularity: 1102.731,
  posterPath: '/lJA2RCMfsWoskqlQhXPSLFQGXEJ.jpg',
  voteAverage: 7.8,
  voteCount: 9490,
);

final testTvShowList = [testTvShow];

final testTvShowDetail = TvShowDetail(
  backdropPath: 'backdropPath',
  episodeRunTime: const [1],
  firstAirDate: 'firstAirDate',
  genres: const [Genre(id: 1, name: 'Action')],
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

final testWatchlistTvShow = TvShow.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
  'title': 'name',
};
