import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/movie_provider.dart';
import '../constants.dart';
import '../components/details/backdrop.dart';
import '../components/details/genres.dart';
import '../components/details/title_and_favourite.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routeName = "/movie-details";
  final int index;
  const MovieDetailsScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<MoviesProvider>(context);
    final movie = movieData.findById(index);
    final genreNameList = movieData.getGenresNamesById(index);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kThemeBaseColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BackdropImage(size: size, movie: movie),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: TitleDurationAndFavBtn(movie: movie),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: Genres(movie: genreNameList),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding,
                ),
                child: Text(
                  "Description ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Text(
                  movie.overview ?? "",
                  style: const TextStyle(
                    color: Color(0xFFE4ECEF),
                    height: 1.8,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
