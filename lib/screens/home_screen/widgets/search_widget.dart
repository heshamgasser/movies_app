import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import '../../../componant/constant.dart';
import '../../../models/movie_details_similar_withArguments/argument_model.dart';
import '../../../remote/api_manager.dart';
import '../../movie_detail_screen/movie_detail_screen.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => showResults(context),
        icon: Icon(
          Icons.search,
          size: 30.r,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.close,
        size: 30.r,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getMoviesSearchByCategory(query),
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
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.local_movies,
                size: 100.w,
                color: Color(0xFFB5B4B4),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'No Movies Found',
                  style: TextStyle(color: Color(0xFFB5B4B4), fontSize: 13.sp),
                ),
              )
            ],
          );
        }
        return query.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.local_movies,
              size: 100.w,
              color: Color(0xFFB5B4B4),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text(
                'No Movies Found',
                style: TextStyle(color: Color(0xFFB5B4B4), fontSize: 13.sp),
              ),
            )
          ],
        )
            : Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      MovieDetailScreen.routeName,
                      arguments: ArgumentModel(
                          movieId: snapshot.data!.results![index].id!),
                    );
                  },
                  child: Container(
                    height: 90.h,
                    child: Row(
                      children: [
                        Container(
                          height: 90.h,
                          width: 140.w,
                          child: CachedNetworkImage(
                            fit: BoxFit.fitHeight,
                            imageUrl:
                            '${IMAGE_BASE_URL}${snapshot.data?.results?[index].posterPath}' ??
                                '',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                snapshot.data?.results?[index].title ??
                                    '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                snapshot.data?.results?[index]
                                    .releaseDate ??
                                    '',
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.grey),
                              ),
                              SizedBox(height: 5.h),
                              VoteWidget(
                                  '${snapshot.data?.results?[index].voteAverage}' ??
                                      ''),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10.h);
              },
              itemCount: snapshot.data!.results!.length),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getMoviesSearchByCategory(query),
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
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.local_movies,
                size: 100.w,
                color: Color(0xFFB5B4B4),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'No Movies Found',
                  style: TextStyle(color: Color(0xFFB5B4B4), fontSize: 13.sp),
                ),
              )
            ],
          );
        }
        return query.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.local_movies,
                    size: 100.w,
                    color: Color(0xFFB5B4B4),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      'No Movies Found',
                      style: TextStyle(color: Color(0xFFB5B4B4), fontSize: 13.sp),
                    ),
                  )
                ],
              )
            : Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            MovieDetailScreen.routeName,
                            arguments: ArgumentModel(
                                movieId: snapshot.data!.results![index].id!),
                          );
                        },
                        child: Container(
                          height: 90.h,
                          child: Row(
                            children: [
                              Container(
                                height: 90.h,
                                width: 140.w,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fitHeight,
                                  imageUrl:
                                      '${IMAGE_BASE_URL}${snapshot.data?.results?[index].posterPath}' ??
                                          '',
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      snapshot.data?.results?[index].title ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      snapshot.data?.results?[index]
                                              .releaseDate ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 13.sp, color: Colors.grey),
                                    ),
                                    SizedBox(height: 5.h),
                                    VoteWidget(
                                        '${snapshot.data?.results?[index].voteAverage}' ??
                                            ''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10.h);
                    },
                    itemCount: snapshot.data!.results!.length),
              );
      },
    );
  }
}
