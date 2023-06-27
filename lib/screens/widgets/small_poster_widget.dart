// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:movies_app/remote/api_manager.dart';
//
// import '../../componant/constant.dart';
//
// class PosterWidget extends StatelessWidget {
//   int selectedMovie;
//
//   PosterWidget(this.selectedMovie);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: ApiManager.getPopularMovies(),
//       builder: (context, snapshot) {
//         return  Container(
//           width: MediaQuery.of(context).size.width * .3,
//           height: MediaQuery.of(context).size.height * .2,
//           child: CachedNetworkImage(
//             fit: BoxFit.fill,
//             imageUrl:
//             '$IMAGE_BASE_URL${snapshot.data?.results?[selectedMovie].posterPath}' ??
//                 '',
//             progressIndicatorBuilder:
//                 (context, url, downloadProgress) => Center(
//                 child: CircularProgressIndicator(
//                     value: downloadProgress.progress)),
//             errorWidget: (context, url, error) => Icon(Icons.error),
//           ),
//         );
//       },);
//
//
//   }
// }
