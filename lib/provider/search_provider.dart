import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{
  TextEditingController searchController = TextEditingController();

  void onSearchButtonClicked () {
    searchController.text;
    notifyListeners();
  }

  void onCloseButtonClicked (){
    searchController.text = '';
    notifyListeners();
  }

}