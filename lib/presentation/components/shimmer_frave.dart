import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFrave extends StatelessWidget {

  const ShimmerFrave({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Color(0xFFF3F3F3),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200]
        ),
      ),
    );
  }
}