import 'package:flutter/material.dart';

class VoteWidget extends StatelessWidget {
  String vote;

  VoteWidget(this.vote);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: Colors.orangeAccent,
        ),
        SizedBox(width: 5),
        Text(
          vote,
          style: TextStyle(
              color: Colors.orangeAccent, fontSize: 10),
        ),
      ],
    );
  }
}
