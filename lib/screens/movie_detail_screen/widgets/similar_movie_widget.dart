import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/SimilarMoviesModel.dart';
import 'package:movies_app/remote/api_manager.dart';
import '../../../componant/constant.dart';
import '../../../models/firebase_data_model.dart';
import '../../../models/movie_details_similar_withArguments/argument_model.dart';
import '../../../shared/remote/firebase_function.dart';
import '../../../styles/app_color.dart';
import '../../home_screen/widgets/movie_poster_widget.dart';
import '../movie_detail_screen.dart';

class SimilarMoviesWidget extends StatelessWidget {
  num movieId;

  SimilarMoviesWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSimilarMovies(movieId),
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

        List<Results> snapshotData = snapshot.data?.results ?? [];
        return Container(
          height: 230.h,
          color: containerColor,
          child: Padding(
            padding: EdgeInsets.only(top: 9.h, bottom: 17.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'More Like This',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MoviePosterWidget(
                          posterPath:
                              '$IMAGE_BASE_URL${snapshotData[index].posterPath}' ??
                                  '',
                          voteText: '${snapshotData[index].voteAverage}' ?? '',
                          title: snapshotData[index].title ?? '',
                          releaseDate: snapshotData[index].releaseDate ?? '',
                          onTapped: () {
                            Navigator.pushReplacementNamed(
                                arguments: ArgumentModel(
                                    movieId:
                                        snapshot.data!.results![index].id!),
                                context,
                                MovieDetailScreen.routeName);
                          },
                          onPressed: () {
                            FirebaseDataModel firebaseDataModel = FirebaseDataModel(
                                id: snapshotData[index].id ?? 0,
                                title: snapshotData[index].title ?? '',
                                posterPath:
                                    '$IMAGE_BASE_URL${snapshotData[index].posterPath}' ??
                                        '',
                                releaseDate:
                                    snapshotData[index].releaseDate ?? '',
                                voteCount: snapshotData[index].voteAverage ?? 0,
                                selected: true);

                            // HomeScreenCubit.get(context).selected
                            //     ?
                            FirebaseFunction.addMovieToWishList(
                                    firebaseDataModel);
                                // : FirebaseFunction.removeFromWishlist(
                                //     snapshotData[index].id!);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                      itemCount: snapshot.data!.results!.length),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
