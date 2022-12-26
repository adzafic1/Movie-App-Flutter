import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imbdmovie/models/movie.dart';

import '../models/genre.dart';
import '../boxes.dart';

class MoviesProvider with ChangeNotifier {
  List<Result> _movieItems = [];
  List<Result> _favMoviesItem = [];
  List<Genre> genresList = [];

  final movieBox = Boxes.getMovies().get('movies');
  Box favMovieBox = Boxes.getResult();
  final genresBox = Boxes.getGenres();

  bool isConnected() {
    return true;
  }

  List<Result> get moviesItems {
    if (movieBox != null && _movieItems.isEmpty) {
      _movieItems = movieBox?.results ?? [];
    }
    return [..._movieItems];
  }

  List<Result> get favMovieItems {
    var listDynamic = [];
    if (favMovieBox.get("favList") != null) {
      listDynamic = favMovieBox.get('favList');
      _favMoviesItem = listDynamic.cast<Result>();
    }
    return [..._favMoviesItem];
  }

  List<Genre> get getGenres {
    var genresBoxValue = genresBox.get('genresList');
    var listDynamic = [];
    if (genresBoxValue != null) {
      listDynamic = genresBoxValue;
      genresList = listDynamic.cast<Genre>();
    }
    return [...genresList];
  }

  Result findById(int id) {
    return _movieItems.firstWhere((movie) => movie.id == id);
  }

  List<Result> addMovies(List<Result> mov) {
    _movieItems = mov;
    notifyListeners();

    return _movieItems;
  }

  List<Result> addFavMoviesList(List<Result> mov) {
    _favMoviesItem = mov;
    notifyListeners();

    return _favMoviesItem;
  }

  List<Result> removeFromFavMoviesList(int existingIndex) {
    _favMoviesItem.removeWhere((item) => item.id == existingIndex);
    notifyListeners();

    return _favMoviesItem;
  }

  void addFavMovies(Result value) {
    _movieItems.add(value);
    notifyListeners();
  }

  List<Genre> addGenres(List<Genre> genres) {
    genresList = genres;
    genresBox.put("genresList", genresList);
    return [...genresList];
  }

  List<String> getGenresNames(int index) {
    List<String> genres = [];
    List<int> genreId = moviesItems[index].genreIds;
    List<Genre> genresNames = getGenres;
    for (var itemGenre in genresNames) {
      for (var item in genreId) {
        if (itemGenre.id == item) {
          genres.add(itemGenre.name.toString());
        }
      }
    }
    return genres;
  }

  List<String> getGenresNamesById(int id) {
    List<String> genres = [];
    Result movie = findById(id);

    for (var item in movie.genreIds) {
      final foundGenreNames = genresList.where((element) => element.id == item);
      for (var item in foundGenreNames) {
        genres.add(item.name.toString());
      }
    }
    return genres;
  }

  bool isMealFavorite(int id) {
    return favMovieItems.any((movie) => movie.id == id);
  }

  void handleFavourites(int id) {
    final existingIndex = _favMoviesItem.indexWhere((movie) => movie.id == id);
    if (existingIndex >= 0) {
      final movieID = _movieItems.firstWhere((movie) => movie.id == id);
      final newList = removeFromFavMoviesList(movieID.id ?? 0);
      favMovieBox.put("favList", newList);
    } else {
      _favMoviesItem.add(
        _movieItems.firstWhere((movie) => movie.id == id),
      );
      favMovieBox.put("favList", _favMoviesItem);
      addFavMoviesList(_favMoviesItem);
    }
  }
}
