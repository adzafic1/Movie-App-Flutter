import 'package:flutter/material.dart';

class ApiConstants {
  static String baseUrl = 'https://api.themoviedb.org/3';
  // static String movies =
  //     '/movie/popular?api_key=b8d7f76947904a011286dc732c55234e&language=en_US&page=1';
  static String genre = '/genre/movie/list';
  static String baseUrlImage = "https://image.tmdb.org/t/p/w500";
  static String imagePath(String path) {
    String imagePath = "$baseUrlImage$path";
    return imagePath;
  }

  static String getMovieAdvanced = "/movie/popular?language=en_US&page=";

  static String pages(int path) {
    String pathStr = "$getMovieAdvanced$path";
    return pathStr;
  }
}

const kDefaultPadding = 20.0;
const kTextLightColor = Colors.yellow;
const kThemeBaseColor = Color(0xFF0E1324);
const kIconColor = Color(0xffEC9B3E);
const bearerToken =
    'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ3Zjc2OTQ3OTA0YTAxMTI4NmRjNzMyYzU1MjM0ZSIsInN1YiI6IjYwMzM3ODBiMTEzODZjMDAzZjk0ZmM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XYuIrLxvowrkevwKx-KhOiOGZ2Tn-R8tEksXq842kX4';
