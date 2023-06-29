import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_screen/widgets/vote_widget.dart';
import '../../../styles/app_color.dart';

class MoviePosterWidget extends StatelessWidget {
  String posterPath;
  String voteText;
  String title;
  String releaseDate;

  MoviePosterWidget(
      {required this.posterPath,
      required this.voteText,
      required this.title,
      required this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: containerColor,
          width: MediaQuery.of(context).size.width * .3,
          height: MediaQuery.of(context).size.height * .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  width: double.infinity,
                  fit: BoxFit.fill,
                  imageUrl: posterPath,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 5),
              VoteWidget('${voteText}' ?? ''),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(fontSize: 10, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text(
                releaseDate,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              )
            ],
          ),
        ),
      ],
    );
  }
}
