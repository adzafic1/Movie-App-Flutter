import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imbdmovie/constants.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../provider/movie_provider.dart';
import '../widget/movie_item.dart';

class MovieList extends StatelessWidget {
  final List<Result> movies;
  // final List<Genre> genreList;

  const MovieList({super.key, required this.movies});

  void selectMovie(BuildContext context, int index) {
    Navigator.pushNamed(context, '/movie-details', arguments: index);
  }

  @override
  Widget build(context) {
    final movieData = Provider.of<MoviesProvider>(context);
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: InkWell(
          onTap: () => selectMovie(context, movies[index].id ?? 0),
          child: Column(
            children: <CustomMovieItem>[
              CustomMovieItem(
                  thumbnail: CachedNetworkImage(
                    imageUrl:
                        ApiConstants.imagePath(movies[index].posterPath ?? ""),
                    height: 100,
                    width: 100,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: kIconColor,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: movies[index].title ?? "",
                  genre: movieData.getGenresNames(index),
                  imbdRatings: movies[index].voteAverage ?? 0.0,
                  favouriteButton:
                      _buildFavouriteButton(context, movies[index].id ?? 0))
            ],
          ),
        ));
      },
    );
  }

  Widget _buildFavouriteButton(BuildContext context, int id) {
    final movieData = Provider.of<MoviesProvider>(context);
    final isFavourite = movieData.isMealFavorite(id);
    return IconButton(
      icon: Icon(
          isFavourite ? Icons.bookmark_added : Icons.bookmark_border_outlined,
          color: isFavourite ? kIconColor : null),
      color: isFavourite ? kIconColor : Colors.white,
      onPressed: () {
        movieData.handleFavourites(id);
      },
    );
  }
}
