import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_cubit.dart';
import 'package:movies_app/screens/home_screen/widgets/small_poster_widget.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import '../../../componant/constant.dart';
import '../../../models/movie_details_similar_withArguments/argument_model.dart';

class PopularMoviesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 290.h,
          child: CarouselSlider(
            items: HomeScreenCubit.get(context).popularResults.map(
              (e) {
                return InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, MovieDetailScreen.routeName,
                        arguments: ArgumentModel(movieId: e.id));
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 290.h,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 290.h,
                      fit: BoxFit.fill,
                      imageUrl: '$IMAGE_BASE_URL${e.backdropPath}' ?? '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              initialPage: HomeScreenCubit.get(context).selectedMovie,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                HomeScreenCubit.get(context).changeSelectedMovie(index);
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.play_circle,
            size: 60.r,
            color: Colors.white,
          ),
        ),
        Positioned(
          bottom: -60.h,
          left: 5.w,
          child: SmallPoster(),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * -.15,
          left: MediaQuery.of(context).size.width * .4,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            height: MediaQuery.of(context).size.height * .2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  HomeScreenCubit.get(context)
                          .popularResults[
                              HomeScreenCubit.get(context).selectedMovie]
                          .title ??
                      '',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Release Date: ${HomeScreenCubit.get(context).popularResults[HomeScreenCubit.get(context).selectedMovie].releaseDate}' ??
                      '',
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // ChangeNotifierProvider(
    //   create: (context) => HomeProvider(),
    //   builder: (context, child) {
    //     var pro = Provider.of<HomeProvider>(context);
    //     return Stack(
    //       clipBehavior: Clip.none,
    //       alignment: Alignment.center,
    //       children: [
    //         CarouselSlider(
    //           items: popular.map(
    //                 (e) {
    //               return InkWell(
    //                 onTap: () {
    //                   Navigator.pushReplacementNamed(
    //                       context, MovieDetailScreen.routeName,
    //                       arguments: ArgumentModel(
    //                           movieId: e.id));
    //                 },
    //                 child: Container(
    //                   width: double.infinity,
    //                   height: 290.h,
    //                   child: CachedNetworkImage(
    //                     width: double.infinity,
    //                     fit: BoxFit.fill,
    //                     imageUrl: '$IMAGE_BASE_URL${e.backdropPath}' ?? '',
    //                     progressIndicatorBuilder:
    //                         (context, url, downloadProgress) =>
    //                         Center(
    //                           child: CircularProgressIndicator(
    //                               value: downloadProgress.progress),
    //                         ),
    //                     errorWidget: (context, url, error) => Icon(Icons.error),
    //                   ),
    //                 ),
    //               );
    //             },
    //           ).toList(),
    //           options: CarouselOptions(
    //             enableInfiniteScroll: false,
    //             initialPage: pro.selectedMovie,
    //             scrollDirection: Axis.horizontal,
    //             onPageChanged: (index, reason) {
    //               pro.changeSelectedMovie(index);
    //             },
    //           ),
    //         ),
    //         IconButton(
    //           onPressed: () {},
    //           icon: Icon(
    //             Icons.play_circle,
    //             size: 60.r,
    //             color: Colors.white,
    //           ),
    //         ),
    //         Positioned(
    //           bottom: -60.h,
    //           left: 5.w,
    //           child: SmallPoster(movieId: popular[pro.selectedMovie].id, posterPath: '$IMAGE_BASE_URL${popular[pro
    //               .selectedMovie].posterPath}', voteCount: '${popular[pro.selectedMovie]
    //               .voteAverage}'),
    //
    //         ),
    //         Positioned(
    //           bottom: MediaQuery
    //               .of(context)
    //               .size
    //               .height * -.15.h,
    //           left: MediaQuery
    //               .of(context)
    //               .size
    //               .width * .4.w,
    //           child: Container(
    //             width: MediaQuery
    //                 .of(context)
    //                 .size
    //                 .width * .6,
    //             height: MediaQuery
    //                 .of(context)
    //                 .size
    //                 .height * .2,
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: [
    //                 Text(
    //                   popular[pro.selectedMovie].title ?? '',
    //                   style: TextStyle(color: Colors.white, fontSize: 14.sp),
    //                 ),
    //                 SizedBox(height: 10.h),
    //                 Text(
    //                   'Release Date: ${popular[pro
    //                       .selectedMovie].releaseDate}' ??
    //                       '',
    //                   style: TextStyle(color: Colors.white, fontSize: 10.sp),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
