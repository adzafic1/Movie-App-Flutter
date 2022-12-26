import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/movie.dart';
import '../../constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class BackdropImage extends StatelessWidget {
  const BackdropImage({required this.size, required this.movie, super.key});

  final Size size;
  final Result movie;

  @override
  Widget build(BuildContext context) {
    String pathImage = '${ApiConstants.baseUrlImage}${movie.backdropPath}';
    return SizedBox(
      // 40% of our total height
      height: size.height * 0.37,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.37,
            child: CachedNetworkImage(
              imageUrl: pathImage,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(
                color: kIconColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          // Back Button
          const SafeArea(
              child: BackButton(
            color: Colors.white,
          )),
        ],
      ),
    );
  }
}
