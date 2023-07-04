import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/provider/search_provider.dart';
import 'package:movies_app/screens/search_screen/widgets/search_text_form_field.dart';
import 'package:provider/provider.dart';
import '../../componant/constant.dart';
import '../../models/movie_details_similar_withArguments/argument_model.dart';
import '../../remote/api_manager.dart';
import '../home_screen/widgets/vote_widget.dart';
import '../movie_detail_screen/movie_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      builder: (context, child) {
        var pro = Provider.of<SearchProvider>(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 35.h),
          child: Column(
            children: [
              SearchTextFormField(
                controller: pro.searchController,
                onSearchPressed: () {
                  pro.onSearchButtonClicked();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onClosePressed: () {
                  pro.onCloseButtonClicked();
                },
              ),
              SizedBox(height: 30.h),
              pro.searchController.text.isEmpty
                  ? Column(
                      children: [
                        Icon(
                          Icons.local_movies,
                          size: 100.w,
                          color: Color(0xFFB5B4B4),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'No Movies Found',
                          style: TextStyle(
                              color: Color(0xFFB5B4B4), fontSize: 13.sp),
                        )
                      ],
                    )
                  : FutureBuilder(
                      future: ApiManager.getMoviesSearchByCategory(
                          pro.searchController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        if (!snapshot.hasData) {
                          return Column(
                            children: [
                              Icon(
                                Icons.local_movies,
                                size: 100.w,
                                color: Color(0xFFB5B4B4),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'No Movies Found',
                                style: TextStyle(
                                    color: Color(0xFFB5B4B4), fontSize: 13.sp),
                              )
                            ],
                          );
                        }
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      MovieDetailScreen.routeName,
                                      arguments: ArgumentModel(
                                          movieId: snapshot
                                                  .data?.results?[index].id ??
                                              ''),
                                    );
                                  },
                                  child: Container(
                                    height: 90.h,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 90.h,
                                          width: 140.w,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                '${IMAGE_BASE_URL}${snapshot.data?.results?[index].posterPath}' ??
                                                    '',
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                snapshot.data?.results?[index]
                                                        .title ??
                                                    '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(height: 5.h),
                                              Text(
                                                snapshot.data?.results?[index]
                                                        .releaseDate ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(height: 5.h),
                                              VoteWidget(
                                                  '${snapshot.data?.results?[index].voteAverage}' ??
                                                      ''),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10.h);
                              },
                              itemCount: snapshot.data!.results!.length),
                        );
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
