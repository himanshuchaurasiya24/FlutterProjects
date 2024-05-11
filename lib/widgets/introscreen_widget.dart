import 'package:flutter/material.dart';
import 'package:vyavasaay_redesigned/utils/constants.dart';
import 'package:vyavasaay_redesigned/widgets/default_container.dart';

class IntroScreenWidget extends StatelessWidget {
  const IntroScreenWidget({
    super.key,
    required this.imageUrl,
    required this.description,
  });
  final String imageUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(defaultSize),
            child: Image.asset(imageUrl),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: titleLargeTextSize,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
