import 'package:flutter/material.dart';

import '../../constants.dart';

class Genres extends StatelessWidget {
  const Genres({
    super.key,
    required this.movie,
  });

  final List<String> movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: SizedBox(
        height: 24,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movie.length,
          itemBuilder: (context, index) => GenreCard(
            genre: movie[index],
          ),
        ),
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
        vertical: kDefaultPadding / 4, // 5 padding top and bottom
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEC9B3E).withOpacity(0.2),
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        genre,
        style: const TextStyle(
            color: Color(0xFFE4ECEF),
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
