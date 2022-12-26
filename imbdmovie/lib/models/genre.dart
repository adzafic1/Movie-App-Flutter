// class Movie2 {
//   final int? id;
//   final int? title;

//   const Movie2({this.id, this.title});

//   factory Movie2.fromJson(Map<String, dynamic> json) {
//     return Movie2(
//       id: json['page'],
//       title: json['total_pages'],
//     );
//   }
// }
// To parse this JSON data, do
//
//     final genreModel = genreModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'genre.g.dart';

GenreModel genreModelFromJson(String str) =>
    GenreModel.fromJson(json.decode(str));

String genreModelToJson(GenreModel data) => json.encode(data.toJson());

@HiveType(typeId: 3)
class GenreModel extends HiveObject {
  GenreModel({
    required this.genres,
  });

  @HiveField(0)
  List<Genre> genres;

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 4)
class Genre {
  Genre({
    this.id,
    this.name,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
