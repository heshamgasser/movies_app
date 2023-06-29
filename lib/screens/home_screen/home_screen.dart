import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/provider/home_provider.dart';
import 'package:movies_app/remote/api_manager.dart';
import 'package:movies_app/screens/home_screen/widgets/coming_soon_movies.dart';
import 'package:movies_app/screens/home_screen/widgets/popular_widget.dart';
import 'package:movies_app/screens/home_screen/widgets/top_rated_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var homeProvider = Provider.of<HomeProvider>(context);
        return FutureBuilder(
          future: ApiManager.getPopularMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Column(
                children: [
                  Text('Error'),
                ],
              );
            }

            return ListView(
              children: [
                PopularMoviesWidget(snapshot: snapshot),
                SizedBox(height: 100.h),
                ComingSoonMovies(),
                SizedBox(height: 10.h),
                TopRatedWidget(),
                // SizedBox(height: 5.h)
              ],
            );
          },
        );
      },
    );
  }
}
