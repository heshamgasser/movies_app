import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed: () {

   }, icon: Icon(Icons.search, size: 30.r, color: Colors.white,),);
  }

  @override
  Widget buildResults(BuildContext context) {
   return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   return Container();
  }
  
}