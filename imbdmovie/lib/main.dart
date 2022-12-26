import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imbdmovie/screens/movie_details_screen.dart';
import 'package:imbdmovie/models/movie.dart';
import 'package:imbdmovie/provider/movie_provider.dart';
import 'package:imbdmovie/service/connection_status.dart';
import 'package:imbdmovie/constants.dart';
import 'components/bottombar/navbar_handler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/genre.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(ResultAdapter());
  Hive.registerAdapter(GenreAdapter());

  await Hive.openBox('genres');
  await Hive.openBox<Movie>('movies');
  await Hive.openBox('favorites');

  // await Hive.openLazyBox<Movie>('movies');
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        // create: (ctx) => MoviesProvider(),
        MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
      ],
      child: MaterialApp(
        title: 'Splash Screen',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        // initialRoute: '/', // default is '/'
        // routes: {
        //   MyHomePage.routeName: (ctx) => const MyHomePage(),
        //   _createRoute(),
        //   MovieDetailsScreen.routeName: (ctx) => const MovieDetailsScreen(),
        // },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/homepage':
              return MaterialPageRoute(
                  builder: (context) => const MyHomePage());
            case '/movie-details':
              if (settings.name == MovieDetailsScreen.routeName) {
                final args = settings.arguments as int;

                return _createRoute(args);
              }
              assert(false, 'Need to implement ${settings.name}');
              return null;
            default:
              return MaterialPageRoute(
                  builder: (context) => const MyHomePage());
          }
        },

        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Route _createRoute(int args) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MovieDetailsScreen(
              index: args,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = "/homepage";
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomBarHandler())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kThemeBaseColor,
        child: Center(
          child: Image.asset("assets/logo.png"),
        ));
  }
}
