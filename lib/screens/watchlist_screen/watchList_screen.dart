import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/firebase_data_model.dart';
import 'package:movies_app/shared/remote/firebase_function.dart';
import '../../componant/constant.dart';
import '../../models/movie_details_similar_withArguments/argument_model.dart';
import '../home_screen/widgets/vote_widget.dart';
import '../movie_detail_screen/movie_detail_screen.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFunction.getDataFromFireStore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<FirebaseDataModel> data = snapshot.data?.docs.map((e) {
              return e.data();
            }).toList() ??
            [];

        return  Padding(
                padding: EdgeInsets.only(
                    top: 50.h, bottom: 10.h, left: 10.w, right: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Watchlist',
                      // arg.title,
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ),
                    SizedBox(height: 15.h),
                    data.isEmpty
                        ? Center(
                          child: Column(
                      children: [
                          Icon(
                            Icons.local_movies,
                            size: 100.w,
                            color: Color(0xFFB5B4B4),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'No Movies Found',
                            style: TextStyle(color: Color(0xFFB5B4B4), fontSize: 13.sp),
                          )
                      ],
                    ),
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
                                      movieId: data[index].id
                                      // snapshot.data?.results?[index].id ??
                                      ),
                                );
                              },
                              child: Card(
                                elevation: 2,
                                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 150.h,
                                      width: 170.w,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: data[index].posterPath ??
                                            // '${IMAGE_BASE_URL}${snapshot.data?.results?[index].posterPath}' ??
                                            '',
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress)),
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
                                            data[index].title ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            data[index].releaseDate ?? '',
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(height: 15.h),
                                          VoteWidget('${data[index].voteCount}')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.white,
                              thickness: 1,
                              indent: 5.w,
                              endIndent: 5.w,
                            );
                          },
                          itemCount: snapshot.data!.docs.length),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
