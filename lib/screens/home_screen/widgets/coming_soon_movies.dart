import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
        return  Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .2,
            color: containerColor,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        color: Colors.blueAccent,
                        width: MediaQuery.of(context).size.width * .3,
                        height: MediaQuery.of(context).size.height * .2,
                        child: CachedNetworkImage(
                          width: double.infinity,
                          fit: BoxFit.fill,
                          imageUrl: '$IMAGE_BASE_URL${snapshot.data?.results?[index].posterPath}' ?? '',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.bookmark,
                            size: 60,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemCount: snapshot.data?.results?.length ?? 1),
          ),
        );
      },);;
  }
}
