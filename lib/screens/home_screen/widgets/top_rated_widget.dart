import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/remote/api_manager.dart';
import 'package:movies_app/screens/home_screen/widgets/movie_poster_widget.dart';
import '../../../componant/constant.dart';
import '../../../styles/app_color.dart';

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getTopRatedMovies(),
      builder: (context, snapshot) {
        return Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
            color: containerColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Recomended',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
                SizedBox(height: 5.h),
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MoviePosterWidget(
                            posterPath:
                                '$IMAGE_BASE_URL${snapshot.data?.results?[index].backdropPath}' ??
                                    '',
                            voteText:
                                '${snapshot.data?.results?[index].voteAverage}' ?? '',
                            title: snapshot.data?.results?[index].title ?? '',
                            releaseDate:
                                '${snapshot.data?.results?[index].releaseDate?.substring(0, 4)} R');
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
          ),
        );
      },
    );
  }
}
