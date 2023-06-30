import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextFormField extends StatelessWidget {
  TextEditingController controller;
  Function onPressed;


  SearchTextFormField({required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

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
          onPressed();
        }, icon: Icon(Icons.search, size: 30, color: Colors.white,),),
      ),
    );
  }
}
