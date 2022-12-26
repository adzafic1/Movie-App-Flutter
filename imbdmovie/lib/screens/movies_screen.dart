import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imbdmovie/provider/movie_provider.dart';
import 'package:imbdmovie/constants.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../components/movie_list.dart';
import '../models/movie.dart';
import '../service/api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../service/connection_status.dart';
import '../boxes.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});
  @override
  State<MoviesScreen> createState() {
    return _MoviesScreenState();
  }
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<Result> movieList = [];
  int page = 1;
  bool _isLoading = true;
  late bool isOnline;

  late Box movieBox = Boxes.getMovies();
  final scrollController = ScrollController(initialScrollOffset: 50.0);

  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _getGenreData();
    _loadMoreData(page);

    connectionStatus.initialize();
    isOnline = connectionStatus.hasConnection;
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        isOnline = false;
      } else if (result == ConnectivityResult.mobile) {
        isOnline = false;
      } else if (result == ConnectivityResult.none) {
        isOnline = true;
      }
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOnline = !hasConnection;
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void _getGenreData() async {
    await ApiService().getGenres().then((value) {
      Provider.of<MoviesProvider>(context, listen: false)
          .addGenres(value.genres);
    });
  }

  void _loadMoreData(int pageNum) async {
    _isLoading = true;
    pageNum = page;
    ApiService().fetchMovieData(pageNum).then((value) {
      if (value.results.isEmpty) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          movieList.addAll(value.results);
          Provider.of<MoviesProvider>(context, listen: false)
              .addMovies(movieList);
        });
        movieBox.put("movies", value);
      }
      if (page <= value.totalPages) {
        page += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<MoviesProvider>(context);
    final movies = movieData.moviesItems; //movieData.getGenres;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
            width: kDefaultPadding,
            height: kDefaultPadding,
          ),
        ),
        backgroundColor: const Color(0xff0E1324),
        title: Text(isOnline ? "" : "No internet connection"),
        titleTextStyle: const TextStyle(fontSize: 18, color: kIconColor),
      ),
      body: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Color(0xff0E1324)),
          child: Column(
            children: [
              const FavouriteHeader(),
              Expanded(
                child: LazyLoadScrollView(
                  isLoading: _isLoading,
                  onEndOfPage: () => _loadMoreData(page),
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 30),
                        MovieList(movies: movies),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavouriteHeader extends StatelessWidget {
  const FavouriteHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      width: double.infinity,
      child: DecoratedBox(
          decoration: BoxDecoration(color: Color(0xff0E1324)),
          child: Padding(
            padding: EdgeInsets.only(left: kDefaultPadding, top: 10),
            child: Text(
              "Popular ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          )),
    );
  }
}
