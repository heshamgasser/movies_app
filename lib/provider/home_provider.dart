import 'package:flutter/material.dart';
import 'package:movies_app/screens/browse_screen/browse_screen.dart';
import 'package:movies_app/screens/home_screen/home_screen.dart';
import 'package:movies_app/screens/search_screen/search_screen.dart';
import 'package:movies_app/screens/watchList_screen.dart';
import 'package:movies_app/styles/app_color.dart';

class HomeProvider extends ChangeNotifier {
  // List <Widget> screensWidget = [HomeScreen(), SearchScreen(), BrowseScreen(), WatchList()];
  //
  // List <BottomNavigationBarItem> bottomItems = [
  //   BottomNavigationBarItem(
  //     backgroundColor: backgroundColor,
  //       icon: Icon(
  //         Icons.home,
  //       ),
  //       label: 'HOME'),
  //   BottomNavigationBarItem(
  //       backgroundColor: backgroundColor,
  //       icon: Icon(
  //         Icons.search,
  //       ),
  //       label: 'SEARCH'),
  //   BottomNavigationBarItem(
  //       backgroundColor: backgroundColor,
  //       icon: Icon(
  //         Icons.movie_creation,
  //       ),
  //       label: 'BROWSE'),
  //   BottomNavigationBarItem(
  //       backgroundColor: backgroundColor,
  //       icon: Icon(
  //         Icons.bookmarks,
  //       ),
  //       label: 'WATCHLIST'),
  // ];
  // int selectedIndex = 0;
  //
  // void changeSelectedIndex (int index){
  //   selectedIndex = index;
  //   notifyListeners();
  // }

  int selectedMovie = 0;
  void changeSelectedMovie (int index){
    selectedMovie = index;
    notifyListeners();
  }
}