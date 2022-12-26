import 'package:flutter/material.dart';
import 'package:imbdmovie/screens/favorites_screen.dart';
import 'package:imbdmovie/constants.dart';

import '../../screens/movies_screen.dart';

class BottomBarHandler extends StatefulWidget {
  const BottomBarHandler({super.key});

  @override
  State<BottomBarHandler> createState() => _BottomBarHandlerState();
}

class _BottomBarHandlerState extends State<BottomBarHandler> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _buildBody = const <Widget>[MoviesScreen(), FavoritesScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _buildBody),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: 'Movie',
            backgroundColor: Colors.white,
            activeIcon: ActiveIconWidget(
              index: _selectedIndex,
            ),
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.bookmark_added_outlined),
              label: 'Favourites',
              backgroundColor: Colors.white,
              activeIcon: ActiveIconWidget(
                index: _selectedIndex,
              )),
        ],
        backgroundColor: kThemeBaseColor,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ActiveIconWidget extends StatelessWidget {
  final int index;
  const ActiveIconWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Column(children: [
        const Divider(
          color: Color(0xffEC9B3E),
          height: 2,
          thickness: 2,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: index == 0
                ? const Icon(Icons.movie)
                : const Icon(Icons.bookmark_added_outlined)
            // Column(
            //   children: [
            //     if (index == 0) ...[
            //       const Icon(Icons.movie),
            //     ] else if (index == 1) ...[
            //       Icon(Icons.bookmark_added_outlined)
            //     ]
            //   ],
            //)

            ),
      ]),
    );
    //   );
  }
}
