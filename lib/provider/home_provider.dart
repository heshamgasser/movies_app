import 'package:flutter/material.dart';
import 'package:movies_app/screens/browse_screen/browse_screen.dart';
import 'package:movies_app/screens/home_screen/home_screen.dart';
import 'package:movies_app/screens/search_screen.dart';
import 'package:movies_app/screens/watchList_screen.dart';

class HomeProvider extends ChangeNotifier {
  List <Widget> screensWidget = [HomeScreen(), SearchScreen(), BrowseScreen(), WatchList()];

  List <BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.black,
        icon: Icon(
          Icons.home,
        ),
        label: 'HOME'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
        ),
        label: 'SEARCH'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.movie_creation,
        ),
        label: 'BROWSE'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.bookmarks,
        ),
        label: 'WATCHLIST'),
  ];
  int selectedIndex = 0;

  void changeSelectedIndex (int index){
    selectedIndex = index;
    notifyListeners();
  }

  int selectedMovie = 0;
  void changeSelectedMovie (int index){
    selectedMovie = index;
    notifyListeners();
  }
}