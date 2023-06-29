import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_screen/widgets/movie_poster_widget.dart';
import '../../../componant/constant.dart';
import '../../../remote/api_manager.dart';
import '../../../styles/app_color.dart';

class ComingSoonMovies extends StatelessWidget {
  const ComingSoonMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getComingSoonMovies(),
      builder: (context, snapshot) {
        return Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .2,
            color: containerColor,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MoviePosterWidget(
                      posterPath:
                          '$IMAGE_BASE_URL${snapshot.data?.results?[index].posterPath}' ??
                              '',
                      voteText:
                          '${snapshot.data?.results?[index].voteAverage ?? ''}',
                      title: '${snapshot.data?.results?[index].title ?? ''}',
                      releaseDate:
                          '${snapshot.data?.results?[index].releaseDate?.substring(0, 4) ?? ''}');
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemCount: snapshot.data?.results?.length ?? 1),
          ),
        );
      },
    );
    ;
  }
}
