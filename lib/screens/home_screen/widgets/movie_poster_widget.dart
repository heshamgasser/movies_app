import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import '../../../styles/app_color.dart';

class MoviePosterWidget extends StatelessWidget {
  String posterPath;
  String voteText;
  String title;
  String releaseDate;
  Function onTapped;

  MoviePosterWidget(
      {required this.posterPath,
      required this.voteText,
      required this.title,
      required this.releaseDate, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            onTapped();
          },
          child: Container(
            color: containerColor,
            width: 97.w,
            height: 187.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    width: 97.w,
                    height: 187.h,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.fill,
                      imageUrl: posterPath,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                VoteWidget('${voteText}' ?? ''),
                SizedBox(height: 5.h),
                Text(
                  title,
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                  releaseDate,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          width: 27.w ,
          height: 36.h,
          child: Icon(Icons.bookmark_add, color: Color(0xFF514F4F).withOpacity(.87), size: 36.h,),
        ),
      ],
    );
  }
}
