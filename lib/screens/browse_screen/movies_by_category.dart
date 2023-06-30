import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/argument_model.dart';
import 'package:movies_app/remote/api_manager.dart';
import 'package:movies_app/screens/browse_screen/browse_screen.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:movies_app/styles/app_color.dart';

import '../../componant/constant.dart';

class MoviesByCategory extends StatelessWidget {
  String categoryName;

  MoviesByCategory(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getMoviesSearchByCategory(categoryName),
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

        return Container(
          height: MediaQuery.of(context).size.height * .9.h,
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        categoryName ?? '',
                        // arg.title,
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, MovieDetailScreen.routeName,
                              arguments: ArgumentModel(
                                  movieId:
                                      snapshot.data?.results?[index].id ?? ''),);
                        },
                        child: Container(
                          height: 90.h,
                          child: Row(
                            children: [
                              Container(
                                height: 90.h,
                                width: 140.w,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      '${IMAGE_BASE_URL}${snapshot.data?.results?[index].posterPath ?? ''}',
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Center(
                                          child: CircularProgressIndicator(
                                              value:
                                                  downloadProgress.progress)),
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
                                          color: Colors.white),
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
                                            '')
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
              ),
            ],
          ),
        );
      },
    );
  }
}
