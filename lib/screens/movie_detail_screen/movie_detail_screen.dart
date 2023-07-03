import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/home_layout/home_layout_screen.dart';
import 'package:movies_app/remote/api_manager.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_bloc/movie_detail_cubit.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_bloc/movie_detail_states.dart';
import 'package:movies_app/screens/movie_detail_screen/widgets/similar_movie_widget.dart';
import 'package:movies_app/styles/app_color.dart';
import '../../componant/constant.dart';
import '../../models/movie_details_similar_withArguments/argument_model.dart';

class MovieDetailScreen extends StatelessWidget {
  static const String routeName = 'Movie Details';

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as ArgumentModel;

    return
        FutureBuilder(
        future: ApiManager.getMovieDetails(arg.movieId),
        builder: (context, snapshot) {
          var category = snapshot.data?.genres ?? [];
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: BackButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, HomeLayout.routeName);
                },
              ),
              centerTitle: true,
              title: Text(
                snapshot.data?.title ?? '',
                // arg.title,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      width: double.infinity,
                      height: 217.h,
                      imageUrl: '${IMAGE_BASE_URL}${snapshot.data?.backdropPath}',
                      // ${arg.imageBackground}",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.play_circle,
                        size: 60.r,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  snapshot.data?.title ?? '',
                  // arg.title ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Release Date: ${snapshot.data?.releaseDate}',
                  // ${arg.releaseDate}',
                  style: TextStyle(color: Color(0xFFB5B4B4), fontSize: 10.sp),
                ),
                SizedBox(height: 19.h),
                SizedBox(
                  height: 199.h,
                  width: double.infinity,
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "${IMAGE_BASE_URL}${snapshot.data?.posterPath}",
                        // ${arg.poster}",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(width: 11.w),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 5.w,
                                        mainAxisSpacing: 3.h,
                                        crossAxisCount: 4),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: Color(0xFFCBCBCB),
                                      ),
                                    ),
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(category[index].name ?? '', style: TextStyle(color: Color(0xFFCBCBCB), fontSize: 10.sp),)),
                                  );
                                },
                                itemCount: category.length,
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  snapshot.data?.overview ?? '',
                                  style: TextStyle(
                                      color: Color(0xFFCBCBCB), fontSize: 13.sp),
                                  softWrap: true,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            VoteWidget('${snapshot.data?.voteAverage}')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                Expanded(child: SimilarMoviesWidget(arg.movieId)),

              ],
            ),
          );
        },
      );



      BlocProvider(
        create: (context) => MovieDetailsCubit()..getMovieDetails(arg.movieId),
        child: BlocConsumer<MovieDetailsCubit, MovieDetailsStates>(
          listener: (context, state) {
            if (state is MovieDetailLoadingState) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: BackButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, HomeLayout.routeName);
                  },
                ),
                centerTitle: true,
                title: Text(
                  MovieDetailsCubit.get(context).movieDetailsData.title ?? '',
                  // arg.title,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${IMAGE_BASE_URL}${MovieDetailsCubit.get(context).movieDetailsData.backdropPath}' ??
                                '',
                        // ${arg.imageBackground}",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_circle,
                          size: 60.r,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    MovieDetailsCubit.get(context).movieDetailsData.title ?? '',
                    // arg.title ?? '',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Release Date: ''${MovieDetailsCubit.get(context).movieDetailsData.releaseDate}' ??
                        '',
                    // ${arg.releaseDate}',
                    style: TextStyle(color: Color(0xFFB5B4B4), fontSize: 10.sp),
                  ),
                  SizedBox(height: 19.h),
                  SizedBox(
                    height: 199.h,
                    child: Row(
                      children: [
                        Container(
                          width: 129.w,
                          child: CachedNetworkImage(
                            imageUrl:
                                "${IMAGE_BASE_URL}${MovieDetailsCubit.get(context).movieDetailsData.posterPath}" ??
                                    '',
                            // ${arg.poster}",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(width: 11.w),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 5.w,
                                          mainAxisSpacing: 3.h,
                                          crossAxisCount: 4),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        border: Border.all(
                                          color: Color(0xFFCBCBCB),
                                        ),
                                      ),
                                      child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            MovieDetailsCubit.get(context)
                                                    .movieDetailsData
                                                    .genres?[index]
                                                    .name ??
                                                '',
                                            style: TextStyle(
                                                color: Color(0xFFCBCBCB),
                                                fontSize: 10.sp),
                                          )),
                                    );
                                  },
                                  itemCount: MovieDetailsCubit.get(context)
                                      .movieDetailsData
                                      .genres
                                      ?.length,
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    MovieDetailsCubit.get(context)
                                            .movieDetailsData
                                            .overview ??
                                        '',
                                    style: TextStyle(
                                        color: Color(0xFFCBCBCB),
                                        fontSize: 13.sp),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              VoteWidget(
                                  '${MovieDetailsCubit.get(context).movieDetailsData.voteAverage}' ?? '')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Expanded(child: SimilarMoviesWidget(arg.movieId)),
                ],
              ),
            );
          },
        ));


  }
}
