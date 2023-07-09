import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_cubit.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_states.dart';
import 'package:movies_app/screens/home_screen/widgets/movie_poster_widget.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import '../../../componant/constant.dart';
import '../../../models/firebase_data_model.dart';
import '../../../models/movie_details_similar_withArguments/argument_model.dart';
import '../../../shared/remote/firebase_function.dart';
import '../../../styles/app_color.dart';

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Container(
          height: 200.h,
          color: containerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Recommended',
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MoviePosterWidget(
                        posterPath:
                        '$IMAGE_BASE_URL${HomeScreenCubit.get(context).topRatedResult[index].backdropPath}' ??
                            '',
                        voteText:
                        '${HomeScreenCubit.get(context).topRatedResult[index].voteAverage}' ??
                            '',
                        title: HomeScreenCubit.get(context).topRatedResult[index].title ?? '',
                        releaseDate:
                        HomeScreenCubit.get(context).topRatedResult[index].releaseDate ?? '',
                        onTapped: () {
                          Navigator.pushReplacementNamed(
                            context,
                            MovieDetailScreen.routeName,
                            arguments: ArgumentModel(
                              movieId: HomeScreenCubit.get(context).topRatedResult[index].id,
                            ),
                          );
                        },
                        onPressed: (){
                          FirebaseDataModel firebaseDataModel = FirebaseDataModel(
                              id: HomeScreenCubit.get(context)
                                  .topRatedResult[index]
                                  .id,
                              title: HomeScreenCubit.get(context)
                                  .topRatedResult[index]
                                  .title,
                              posterPath:
                              '$IMAGE_BASE_URL${HomeScreenCubit.get(context).topRatedResult[index].posterPath}' ??
                                  '',
                              releaseDate: HomeScreenCubit.get(context)
                                  .topRatedResult[index]
                                  .releaseDate,
                              voteCount: HomeScreenCubit.get(context)
                                  .topRatedResult[index]
                                  .voteAverage,
                              // selected: HomeScreenCubit.get(context).selected ? true : false
                          );

                          // HomeScreenCubit.get(context).selected
                          //     ?
                          FirebaseFunction.addMovieToWishList(firebaseDataModel)
                              // : FirebaseFunction.removeFromWishlist(HomeScreenCubit.get(
                              // context)
                              // .popularResults[index]
                              // .id)
                          ;
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                    itemCount: HomeScreenCubit.get(context).topRatedResult.length),
              ),
            ],
          ),
        );
      },
    );






    //   FutureBuilder(
    //   future: ApiManager.getTopRatedMovies(),
    //   builder: (context, snapshot) {
    //     return Container(
    //       height: 187.h,
    //       color: containerColor,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           Text(
    //             'Recomended',
    //             style: TextStyle(color: Colors.white, fontSize: 15.sp),
    //           ),
    //           SizedBox(height: 5.h),
    //           Expanded(
    //             child: ListView.separated(
    //                 scrollDirection: Axis.horizontal,
    //                 itemBuilder: (context, index) {
    //                   return MoviePosterWidget(
    //                     posterPath:
    //                         '$IMAGE_BASE_URL${snapshot.data?.results?[index].backdropPath}' ??
    //                             '',
    //                     voteText:
    //                         '${snapshot.data?.results?[index].voteAverage}' ??
    //                             '',
    //                     title: snapshot.data?.results?[index].title ?? '',
    //                     releaseDate:
    //                         snapshot.data?.results?[index].releaseDate ?? '',
    //                     onTapped: () {
    //                       Navigator.pushReplacementNamed(
    //                         context,
    //                         MovieDetailScreen.routeName,
    //                         arguments: ArgumentModel(
    //                           movieId: snapshot.data?.results?[index].id,
    //                         ),
    //                       );
    //                     },
    //                   );
    //                 },
    //                 separatorBuilder: (context, index) {
    //                   return SizedBox(
    //                     width: 10.w,
    //                   );
    //                 },
    //                 itemCount: snapshot.data?.results?.length ?? 1),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
