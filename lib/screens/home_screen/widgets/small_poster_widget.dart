import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import '../../../models/movie_details_similar_withArguments/argument_model.dart';
import '../../movie_detail_screen/movie_detail_screen.dart';

class SmallPoster extends StatelessWidget {
  var movieId;
  String posterPath;
  String voteCount;



  SmallPoster({required this.movieId,required this.posterPath,required this.voteCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 129.w,
          height: 199.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, MovieDetailScreen.routeName,
                        arguments: ArgumentModel(
                            movieId: movieId),);
                  },
                  child: SizedBox(
                    width: 129.w,
                    height: 199.h,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:
                      posterPath ??
                          '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                          Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              VoteWidget(
                  voteCount),
            ],
          ),
        ),
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            // FirebaseFunction.addMovieToWishList(movieDetailsModel);
          },
          child: Icon(Icons.bookmark_add_rounded, color: Color(0xFF514F4F).withOpacity(.87), size: 36.h,),
        ),
      ],
    );
  }
}
