import 'package:flutter/material.dart';
import 'package:imbdmovie/provider/movie_provider.dart';
import 'package:imbdmovie/constants.dart';
import 'package:provider/provider.dart';

import '../components/movie_list.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<MoviesProvider>(context);
    final favMovies = movieData.favMovieItems;
    final isEmpty = movieData.favMovieItems.isEmpty;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
            width: 20,
            height: 20,
          ),
        ),
        backgroundColor: const Color(0xff0E1324),
      ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Color(0xff0E1324)),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const FavouritesHeading(),
              Expanded(
                child: isEmpty
                    ? const NoFavoritesWidget()
                    : MovieList(movies: favMovies),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavouritesHeading extends StatelessWidget {
  const FavouritesHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      width: double.infinity,
      child: DecoratedBox(
          decoration: BoxDecoration(color: Color(0xff0E1324)),
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10),
            child: Text(
              "Favourites ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          )),
    );
  }
}

class NoFavoritesWidget extends StatelessWidget {
  const NoFavoritesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No favourites yet",
        style: TextStyle(
            color: kIconColor, fontSize: 26, fontWeight: FontWeight.w400),
      ),
    );
  }
}
