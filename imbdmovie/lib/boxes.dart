import 'package:hive/hive.dart';
import 'models/movie.dart';

class Boxes {
  static Box<Movie> getMovies() => Hive.box<Movie>('movies');
  static Box getResult() => Hive.box('favorites');
  static Box getGenres() => Hive.box('genres');
}
