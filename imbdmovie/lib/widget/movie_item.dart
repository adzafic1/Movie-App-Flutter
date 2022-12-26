import 'package:flutter/material.dart';

import '../components/details/genres.dart';

class CustomMovieItem extends StatelessWidget {
  const CustomMovieItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.genre,
    required this.imbdRatings,
    required this.favouriteButton,
  });

  final Widget thumbnail;
  final String title;
  final List<String> genre;
  final double imbdRatings;
  final Widget favouriteButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Ink(
        color: const Color(0xff0E1324),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: thumbnail,
            ),
            Expanded(
              flex: 4,
              child: _MovieDescription(
                title: title,
                genreNames: genre,
                imbdRatings: imbdRatings,
              ),
            ),
            favouriteButton,
          ],
        ),
      ),
    );
  }
}

class _MovieDescription extends StatelessWidget {
  const _MovieDescription({
    required this.title,
    required this.genreNames,
    required this.imbdRatings,
  });

  final String title;
  final List<String> genreNames;
  final double imbdRatings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
          Text.rich(
            TextSpan(
              children: [
                const WidgetSpan(
                    child: Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 18,
                )),
                TextSpan(
                  text: '$imbdRatings /10',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 12.0)),
          Genres(
            movie: genreNames,
          )
        ],
      ),
    );
  }
}
