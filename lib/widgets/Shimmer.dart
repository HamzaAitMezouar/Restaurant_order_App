import 'package:flutter/material.dart';
import 'package:restaurant_menu/widgets/FadeAnimation.dart';

import 'package:shimmer/shimmer.dart';

class Shimmerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FadeAnimation(
      1.7,
      Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 230, 230, 230),
          highlightColor: Color.fromARGB(255, 155, 155, 155),
          child: GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            children: [
              ShimmerContainer(size),
              ShimmerContainer(size),
              ShimmerContainer(size),
              ShimmerContainer(size),
            ],
          )),
    );
  }

  Container ShimmerContainer(Size size) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: size.height * 0.5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.red,
                width: size.width * 0.054,
                height: size.height * 0.022,
              ),
              SizedBox(
                width: size.width * 0.08,
              ),
            ], //image
          ),
          SizedBox(
            width: size.width * 0.08,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            height: size.height * 0.17,
            width: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            color: Colors.red,
            alignment: Alignment.center,
            height: size.height * 0.02,
            width: size.width * 0.3,
          )
        ],
      ),
    );
  }
}
