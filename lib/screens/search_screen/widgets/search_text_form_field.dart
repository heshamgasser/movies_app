import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextFormField extends StatelessWidget {
  TextEditingController controller;
  Function onClosePressed;
  Function onSearchPressed;



  SearchTextFormField({required this.controller, required this.onClosePressed, required this.onSearchPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (value) {
        controller.text = value;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF514F4F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Colors.white,),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Colors.white,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Colors.white,),
        ),
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(onPressed: () {
          onSearchPressed();
        }, icon: Icon(Icons.search, size: 30.r, color: Colors.white,),),
        prefixIcon: IconButton(onPressed: () {
          onClosePressed();
        }, icon: Icon(Icons.close, size: 30.r, color: Colors.white,),),
      ),
    );
  }
}
