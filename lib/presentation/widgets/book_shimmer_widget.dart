import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mangadul/core/utils/utils/color_generator_utils.dart';
import 'package:shimmer/shimmer.dart';

class BookShimmer extends StatelessWidget {
  const BookShimmer(
      {super.key,
      this.height,
      this.width,
      this.baseColor,
      this.highlightColor,
      this.margin});

  final double? height;
  final double? width;
  final Color? baseColor;
  final Color? highlightColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200.w,
      width: width ?? double.infinity,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? ColorGenerator.randomColor(),
        highlightColor: highlightColor ?? ColorGenerator.randomColor(),
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
              color: ColorGenerator.randomColor(),
              borderRadius: BorderRadius.circular(5.w)),
          height: height ?? 200.w,
          width: width ?? double.infinity,
        ),
      ),
    );
  }
}
