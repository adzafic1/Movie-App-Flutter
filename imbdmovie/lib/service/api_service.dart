import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/genre.dart';
import '../constants.dart';
import 'package:imbdmovie/models/movie.dart';

class ApiService {
  Future<Movie> fetchMovieData(int pageNum) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.pages(pageNum));
    final response = await http.get(
      url,
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.contentTypeHeader: "*/*",
        HttpHeaders.authorizationHeader: bearerToken
      },
    );
    if (response.statusCode == 200) {
      Movie movie = Movie.fromJson(json.decode(response.body));
      return movie;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<GenreModel> getGenres() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.genre);
    final response = await http.get(
      url,
      // Send authorization headers to the backend.
      headers: {HttpHeaders.authorizationHeader: bearerToken},
    );
    if (response.statusCode == 200) {
      final movie = genreModelFromJson(response.body);
      return movie;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
