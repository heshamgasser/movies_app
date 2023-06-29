import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/provider/home_provider.dart';
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
          alignment: Alignment.bottomLeft,
          children: [
            CarouselSlider(
              items: snapshot.data?.results?.map(
                (e) {
                  return Container(
                    width: double.infinity,
                    height: 290.h,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.fill,
                      imageUrl: '$IMAGE_BASE_URL${e.backdropPath}' ?? '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
            Positioned(
              bottom: MediaQuery.of(context).size.height * -.1,
              child: Stack(
                children: [
                  Container(
                    width: 129.w,
                    height: 199.h,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:
                          '$IMAGE_BASE_URL${snapshot.data?.results?[pro.selectedMovie].posterPath}' ??
                              '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {},
                    child: Icon(Icons.bookmark_add_rounded,
                        size: 30, color: Colors.blue),
                  ),
                  Positioned(
                      bottom: 5.h,
                      left: 5.w,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.orangeAccent,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '${snapshot.data?.results?[pro.selectedMovie].voteAverage}' ??
                                '',
                            style: TextStyle(color: Colors.orangeAccent),
                          )
                        ],
                      )),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * -.15,
              left: MediaQuery.of(context).size.width * .35,
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      snapshot.data?.results?[pro.selectedMovie].title ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Release Date: ${snapshot.data?.results?[pro.selectedMovie].releaseDate}' ??
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
