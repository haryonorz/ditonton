import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:tv_show/domain/entities/tv_show.dart';

class ContentCard extends StatelessWidget {
  final MenuItem activeMenu;
  final Movie? movie;
  final TvShow? tvShow;
  final String routeName;

  const ContentCard({
    required this.activeMenu,
    this.movie,
    this.tvShow,
    required this.routeName,
    Key? key,
  }) : super(key: key);

  int? _getId() {
    if (activeMenu == MenuItem.movie) return movie?.id;
    return tvShow?.id;
  }

  String? _getTitle() {
    if (activeMenu == MenuItem.movie) return movie?.title;
    return tvShow?.name;
  }

  String? _getOverview() {
    if (activeMenu == MenuItem.movie) return movie?.overview;
    return tvShow?.overview;
  }

  String? _getPosterPath() {
    if (activeMenu == MenuItem.movie) return movie?.posterPath;
    return tvShow?.posterPath;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            routeName,
            arguments: _getId(),
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTitle() ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getOverview() ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$baseImageURL${_getPosterPath()}',
                  width: 80,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
