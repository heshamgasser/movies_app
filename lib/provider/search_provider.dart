import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{
  TextEditingController searchController = TextEditingController();

  void getController () {
    searchController.text;
    notifyListeners();
  }

}