import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/remote/api_manager.dart';
import '../../../componant/constant.dart';
import '../../../models/argument_model.dart';
import '../../../styles/app_color.dart';
import '../../home_screen/widgets/movie_poster_widget.dart';
import '../movie_detail_screen.dart';

class SimilarMoviesWidget extends StatelessWidget {
  int movieId;

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

        return Container(
          height: 187.h,
          color: containerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'More Like This',
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MoviePosterWidget(
                        posterPath:
                            '$IMAGE_BASE_URL${snapshot.data?.results?[index].posterPath}' ??
                                '',
                        voteText:
                            '${snapshot.data?.results?[index].voteAverage ?? ''}',
                        title: snapshot.data?.results?[index].title ?? '',
                        releaseDate: snapshot.data?.results?[index].releaseDate ?? '',
                        onTapped: () {
                          Navigator.pushReplacementNamed(
                              arguments: ArgumentModel(
                                  movieId: snapshot.data?.results?[index].id),
                              context,
                              MovieDetailScreen.routeName);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                    itemCount: snapshot.data?.results?.length ?? 1),
              ),
            ],
          ),
        );
      },
    );
  }
}
