import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/remote/api_manager.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import '../../componant/constant.dart';
import '../../models/movie_details_similar_withArguments/argument_model.dart';

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

        return Padding(
          padding:
              EdgeInsets.only(top: 30.h, bottom: 10.h, left: 10.w, right: 10.w),
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
                            context,
                            MovieDetailScreen.routeName,
                            arguments: ArgumentModel(
                                movieId:
                                    snapshot.data!.results![index].id!),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.transparent,
                          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 150.h,
                                width: 170.w,
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
                                    SizedBox(height: 15.h),
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
                      return Divider(color: Colors.white,thickness: 1, indent: 5.w, endIndent: 5.w,);
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
