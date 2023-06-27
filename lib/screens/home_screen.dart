import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/componant/constant.dart';
import 'package:movies_app/provider/home_provider.dart';
import 'package:movies_app/remote/api_manager.dart';
import 'package:movies_app/screens/widgets/new_release_movies.dart';
import 'package:movies_app/screens/widgets/popular_widget.dart';
import 'package:movies_app/screens/widgets/top_rated_widget.dart';
import 'package:movies_app/styles/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               PopularMoviesWidget(snapshot: snapshot),

                SizedBox(height: MediaQuery.of(context).size.height * .11),

                Text(
                  'New Release',
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 5),

                NewReleaseMovies(),


                // Expanded(
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * .2,
                //     color: containerColor,
                //     child: ListView.separated(
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (context, index) {
                //           return Stack(
                //             children: [
                //               Container(
                //                 color: Colors.blueAccent,
                //                 width: MediaQuery.of(context).size.width * .3,
                //                 height: MediaQuery.of(context).size.height * .2,
                //               ),
                //               Stack(
                //                 alignment: Alignment.center,
                //                 children: [
                //                   Icon(
                //                     Icons.bookmark,
                //                     size: 60,
                //                     color: Colors.grey,
                //                   ),
                //                   Icon(
                //                     Icons.add,
                //                     size: 25,
                //                     color: Colors.white,
                //                   )
                //                 ],
                //               ),
                //             ],
                //           );
                //         },
                //         separatorBuilder: (context, index) {
                //           return SizedBox(
                //             width: 10,
                //           );
                //         },
                //         itemCount: 10),
                //   ),
                // ),

                SizedBox(height: 10),

                Text(
                  'Recomended',
                  style: TextStyle(color: Colors.white),
                ),

                SizedBox(height: 5),

                TopRatedWidget(),

                SizedBox(height: 5)

              ],
            );
          },
        );
      },
    );
  }
}
