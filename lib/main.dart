import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/home_layout/home_screen.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';

void main () {

  runApp(MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:  Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:(context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomeLayout.routeName,
          routes: {
            HomeLayout.routeName:(context) => HomeLayout(),
            MovieDetailScreen.routeName:(context) => MovieDetailScreen(),


          },
        );
      },
    );
  }
}
