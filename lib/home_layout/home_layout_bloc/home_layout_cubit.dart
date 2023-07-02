import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/home_layout/home_layout_bloc/home_layout_states.dart';

import '../../screens/browse_screen/browse_screen.dart';
import '../../screens/home_screen/home_screen.dart';
import '../../screens/search_screen/search_screen.dart';
import '../../screens/watchList_screen.dart';
import '../../styles/app_color.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {

  HomeLayoutCubit() : super(HomeLayoutInitState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  List <Widget> screensWidget = [HomeScreen(), SearchScreen(), BrowseScreen(), WatchList()];

  List <BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        backgroundColor: backgroundColor,
        icon: Icon(
          Icons.home,
        ),
        label: 'HOME'),
    BottomNavigationBarItem(
        backgroundColor: backgroundColor,
        icon: Icon(
          Icons.search,
        ),
        label: 'SEARCH'),
    BottomNavigationBarItem(
        backgroundColor: backgroundColor,
        icon: Icon(
          Icons.movie_creation,
        ),
        label: 'BROWSE'),
    BottomNavigationBarItem(
        backgroundColor: backgroundColor,
        icon: Icon(
          Icons.bookmarks,
        ),
        label: 'WATCHLIST'),
  ];
  int selectedIndex = 0;

  void changeSelectedIndex (int index){
    selectedIndex = index;
   emit(HomeLayoutBottomNavigationChangeState());
  }




}