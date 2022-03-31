import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/menu_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final MenuItem activeMenu;
  final Movie? movie;
  final TvShow? tvShow;
  final String routeName;

  ContentCard({
    required this.activeMenu,
    this.movie,
    this.tvShow,
    required this.routeName,
  });

  int? _getId() {
    if (activeMenu == MenuItem.Movie) return movie?.id;
    return tvShow?.id;
  }

  String? _getTitle() {
    if (activeMenu == MenuItem.Movie) return movie?.title;
    return tvShow?.name;
  }

  String? _getOverview() {
    if (activeMenu == MenuItem.Movie) return movie?.overview;
    return tvShow?.overview;
  }

  String? _getPosterPath() {
    if (activeMenu == MenuItem.Movie) return movie?.posterPath;
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
                    SizedBox(height: 16),
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
                  imageUrl: '$BASE_IMAGE_URL${_getPosterPath()}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
