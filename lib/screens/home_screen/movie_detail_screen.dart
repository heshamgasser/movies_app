import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/home_layout/home_screen.dart';
import 'package:movies_app/models/argument_model.dart';
import 'package:movies_app/styles/app_color.dart';

import '../../componant/constant.dart';

class MovieDetailScreen extends StatelessWidget {
  static const String routeName = 'Movie Details';

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as ArgumentModel;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeLayout.routeName);
          },
        ),
        centerTitle: true,
        title: Text(arg.title, style: TextStyle(fontSize: 20.sp),),
      ),

    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CachedNetworkImage(
          imageUrl: "${IMAGE_BASE_URL}${arg.imageBackground}",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),

        SizedBox(height: 12.h),
        Text(arg.title ?? '', style: TextStyle(color: Colors.white),),
      ],
    ),
    );
  }
}
