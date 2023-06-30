import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/CategoryModel.dart';
import 'package:movies_app/remote/api_manager.dart';
import 'package:movies_app/screens/browse_screen/movies_by_category.dart';
import 'package:movies_app/styles/app_color.dart';

class BrowseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getMoviesCategory(),
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

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'BROWSE CATEGORY',
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 38.w,
                      mainAxisSpacing: 47.h,
                      crossAxisCount: 2),
                  itemCount: snapshot.data!.genres!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: backgroundColor,
                          context: context,
                          builder: (context) {
                            return MoviesByCategory(
                                snapshot.data?.genres?[index].name ?? '');
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF707070)),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Center(
                          child: Text(
                            snapshot.data?.genres?[index].name ?? '',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
