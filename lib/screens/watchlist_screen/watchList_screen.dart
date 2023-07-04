import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../componant/constant.dart';
import '../../models/movie_details_similar_withArguments/argument_model.dart';
import '../home_screen/widgets/vote_widget.dart';
import '../movie_detail_screen/movie_detail_screen.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(top: 50.h, bottom: 10.h, left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Watchlist',
            // arg.title,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
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
                            // snapshot.data?.results?[index].id ??
                                ''),
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
                              fit: BoxFit.cover,
                              imageUrl:
                              // '${IMAGE_BASE_URL}${snapshot.data?.results?[index].posterPath}' ??
                                  '',
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
                                  // snapshot.data?.results?[index].title ??
                                      '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  // snapshot.data?.results?[index].releaseDate ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.grey),
                                ),
                                SizedBox(height: 15.h),
                                VoteWidget(
                                    // '${snapshot.data?.results?[index].voteAverage}' ??
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
                itemCount: 5),
          ),
        ],
      ),
    );
  }
}
