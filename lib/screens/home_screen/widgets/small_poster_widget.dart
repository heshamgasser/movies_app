import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/firebase_data_model.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_cubit.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import '../../../componant/constant.dart';
import '../../../models/movie_details_similar_withArguments/argument_model.dart';
import '../../../shared/remote/firebase_function.dart';
import '../../movie_detail_screen/movie_detail_screen.dart';

class SmallPoster extends StatelessWidget {
  // num movieId;
  // String posterPath;
  // num voteCount;
  // String title;
  // String releaseDate;

  // bool selected;
  // Function onSelected;

  // SmallPoster({
  // required this.movieId,
  // required this.posterPath,
  // required this.voteCount,
  // required this.title,
  // required this.releaseDate,
  // required this.selected,
  // required this.onSelected
  // });

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
                      context,
                      MovieDetailScreen.routeName,
                      arguments: ArgumentModel(
                          movieId: HomeScreenCubit.get(context)
                              .popularResults[
                                  HomeScreenCubit.get(context).selectedMovie]
                              .id),
                    );
                  },
                  child: SizedBox(
                    width: 129.w,
                    height: 199.h,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:
                          '$IMAGE_BASE_URL${HomeScreenCubit.get(context).popularResults[HomeScreenCubit.get(context).selectedMovie].posterPath}' ??
                              '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              VoteWidget(
                  '${HomeScreenCubit.get(context).popularResults[HomeScreenCubit.get(context).selectedMovie].voteAverage}'),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            HomeScreenCubit.get(context).watchlistSelected();
            FirebaseDataModel firebaseDataModel = FirebaseDataModel(
                id: HomeScreenCubit.get(context)
                    .popularResults[HomeScreenCubit.get(context).selectedMovie]
                    .id,
                title: HomeScreenCubit.get(context)
                    .popularResults[HomeScreenCubit.get(context).selectedMovie]
                    .title,
                posterPath:
                    '$IMAGE_BASE_URL${HomeScreenCubit.get(context).popularResults[HomeScreenCubit.get(context).selectedMovie].posterPath}' ??
                        '',
                releaseDate: HomeScreenCubit.get(context)
                    .popularResults[HomeScreenCubit.get(context).selectedMovie]
                    .releaseDate,
                voteCount: HomeScreenCubit.get(context)
                    .popularResults[HomeScreenCubit.get(context).selectedMovie]
                    .voteAverage,
                selected: HomeScreenCubit.get(context).selected ? true : false);

            HomeScreenCubit.get(context).selected
                ? FirebaseFunction.addMovieToWishList(firebaseDataModel)
                : FirebaseFunction.removeFromWishlist(HomeScreenCubit.get(
                        context)
                    .popularResults[HomeScreenCubit.get(context).selectedMovie]
                    .id);
          },
          icon: HomeScreenCubit.get(context).selected
              ? Icon(
                  Icons.bookmark_added_rounded,
                  color: Color(0xFFF7B539).withOpacity(.87),
                  size: 36.h,
                )
              : Icon(
                  Icons.bookmark_add_rounded,
                  color: Color(0xFF514F4F).withOpacity(.87),
                  size: 36.h,
                ),
        )
      ],
    );
  }
}
