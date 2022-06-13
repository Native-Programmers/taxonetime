import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmers(double height, BuildContext context) {
  return Expanded(
    child: Shimmer.fromColors(
      baseColor: Colors.grey.withAlpha(100),
      highlightColor: Colors.grey.withAlpha(10),
      enabled: true,
      child: Container(
        color: Colors.white,
      ),
    ),
  );
}
