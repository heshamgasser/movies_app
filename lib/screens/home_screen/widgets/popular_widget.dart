import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/MovieDetailsModel.dart';
import 'package:movies_app/models/argument_model.dart';
import 'package:movies_app/provider/home_provider.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../../componant/constant.dart';
import '../../../models/PopularMoviesModel.dart';

class PopularMoviesWidget extends StatelessWidget {
  AsyncSnapshot<PopularMoviesModel> snapshot;

  PopularMoviesWidget({
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var pro = Provider.of<HomeProvider>(context);
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              items: snapshot.data?.results?.map(
                    (e) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, MovieDetailScreen.routeName,
                          arguments: ArgumentModel(
                              movieId: e.id));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 290.h,
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: '$IMAGE_BASE_URL${e.backdropPath}' ?? '',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                enableInfiniteScroll: false,
                initialPage: pro.selectedMovie,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  pro.changeSelectedMovie(index);
                },
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_circle,
                size: 60.r,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: -60.h,
              left: 5.w,
              child: Stack(
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
                                      movieId: snapshot.data?.results?[pro.selectedMovie].id));
                            },
                            child: Container(
                              width: 129.w,
                              height: 199.h,
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                '$IMAGE_BASE_URL${snapshot.data?.results?[pro
                                    .selectedMovie].posterPath}' ??
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
                            '${snapshot.data?.results?[pro.selectedMovie]
                                .voteAverage}'),
                      ],
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {},
                    child: Icon(Icons.bookmark_add_rounded, color: Color(0xFF514F4F).withOpacity(.87), size: 36.h,),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery
                  .of(context)
                  .size
                  .height * -.15.h,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * .4.w,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .6,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      snapshot.data?.results?[pro.selectedMovie].title ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Release Date: ${snapshot.data?.results?[pro
                          .selectedMovie].releaseDate}' ??
                          '',
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
