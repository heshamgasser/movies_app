import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/screens/home_screen/widgets/coming_soon_widget/coming_soon_bloc/coming_soon_cubit.dart';
import 'package:movies_app/screens/home_screen/widgets/coming_soon_widget/coming_soon_bloc/coming_soon_states.dart';
import 'package:movies_app/screens/home_screen/widgets/movie_poster_widget.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import '../../../../componant/constant.dart';
import '../../../../models/movie_details_similar_withArguments/argument_model.dart';
import '../../../../remote/api_manager.dart';
import '../../../../styles/app_color.dart';

class ComingSoonMovies extends StatelessWidget {
  const ComingSoonMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComingSoonCubit()..getComingSoonMovies(),
      child: BlocConsumer<ComingSoonCubit, ComingSoonStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            height: 187.h,
            color: containerColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Coming Soon',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
                SizedBox(height: 5.h),
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MoviePosterWidget(
                          posterPath:
                              '$IMAGE_BASE_URL${ComingSoonCubit.get(context).comingSoonResult[index].posterPath}' ??
                                  '',
                          voteText:
                              '${ComingSoonCubit.get(context).comingSoonResult[index].voteAverage ?? ''}',
                          title: ComingSoonCubit.get(context)
                                  .comingSoonResult[index]
                                  .title ??
                              '',
                          releaseDate: ComingSoonCubit.get(context)
                                  .comingSoonResult[index]
                                  .releaseDate ??
                              '',
                          onTapped: () {
                            Navigator.pushReplacementNamed(
                                arguments: ArgumentModel(
                                    movieId: ComingSoonCubit.get(context)
                                        .comingSoonResult[index]
                                        .id),
                                context,
                                MovieDetailScreen.routeName);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                      itemCount: ComingSoonCubit.get(context)
                              .comingSoonResult
                              .length ??
                          1),
                ),
              ],
            ),
          );
        },
      ),
    );




    //   FutureBuilder(
    //   future: ApiManager.getComingSoonMovies(),
    //   builder: (context, snapshot) {
    //     return Container(
    //       height: 187.h,
    //       color: containerColor,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           Text(
    //             'Coming Soon',
    //             style: TextStyle(color: Colors.white, fontSize: 15.sp),
    //           ),
    //           SizedBox(height: 5.h),
    //           Expanded(
    //             child: ListView.separated(
    //                 scrollDirection: Axis.horizontal,
    //                 itemBuilder: (context, index) {
    //                   return MoviePosterWidget(
    //                     posterPath:
    //                         '$IMAGE_BASE_URL${snapshot.data?.results?[index].posterPath}' ??
    //                             '',
    //                     voteText:
    //                         '${snapshot.data?.results?[index].voteAverage ?? ''}',
    //                     title: snapshot.data?.results?[index].title ?? '',
    //                     releaseDate: snapshot.data?.results?[index].releaseDate ?? '',
    //                     onTapped: () {
    //                       Navigator.pushReplacementNamed(
    //                           arguments: ArgumentModel(
    //                             movieId: snapshot.data?.results?[index].id),
    //                           context,
    //                           MovieDetailScreen.routeName);
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
