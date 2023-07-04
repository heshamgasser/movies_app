import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_cubit.dart';
import 'package:movies_app/screens/home_screen/widgets/movie_poster_widget.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import '../../../componant/constant.dart';
import '../../../models/movie_details_similar_withArguments/argument_model.dart';
import '../../../styles/app_color.dart';

class ComingSoonMovies extends StatelessWidget {
  const ComingSoonMovies({super.key});

  @override
  Widget build(BuildContext context) {
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
                    '$IMAGE_BASE_URL${HomeScreenCubit.get(context).comingSoonResult[index].posterPath}' ??
                        '',
                    voteText:
                    '${HomeScreenCubit.get(context).comingSoonResult[index].voteAverage}' ?? '',
                    title: HomeScreenCubit.get(context)
                        .comingSoonResult[index]
                        .title ??
                        '',
                    releaseDate: HomeScreenCubit.get(context)
                        .comingSoonResult[index]
                        .releaseDate ??
                        '',
                    onTapped: () {
                      Navigator.pushReplacementNamed(
                          arguments: ArgumentModel(
                              movieId: HomeScreenCubit.get(context)
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
                itemCount: HomeScreenCubit.get(context)
                    .comingSoonResult.length),
          ),
        ],
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
