import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/movie.dart';
import '../../provider/movie_provider.dart';
import '../../constants.dart';

class TitleDurationAndFavBtn extends StatelessWidget {
  const TitleDurationAndFavBtn({
    super.key,
    required this.movie,
  });

  final Result movie;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<MoviesProvider>(context);
    final isFavourite = productsData.isMealFavorite(movie.id ?? 0);
    return Container(
      // color: kThemeBaseColor,
      decoration: const BoxDecoration(
        color: kThemeBaseColor,
        borderRadius: BorderRadius.horizontal(
            left: Radius.circular(10), right: Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: kDefaultPadding),
        // height: size.height * 0.2 - 50,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: kDefaultPadding),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Row(
                    children: <Widget>[
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
                              text: ' ${movie.voteAverage} /10 IMBd',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 64,
              width: 64,
              child: FloatingActionButton(
                backgroundColor: kThemeBaseColor,
                splashColor: kIconColor,
                onPressed: () {
                  productsData.handleFavourites(movie.id ?? 0);
                },
                child: Icon(
                    isFavourite
                        ? Icons.bookmark_added
                        : Icons.bookmark_border_outlined,
                    color: isFavourite ? kIconColor : null),
              ),
            )
          ],
        ),
      ),
    );
  }
}
