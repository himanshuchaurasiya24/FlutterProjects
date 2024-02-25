import 'package:dbestech_multi_vendor_app/constants/constants.dart';
import 'package:dbestech_multi_vendor_app/shimmers/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodsListShimmer extends StatelessWidget {
  const FoodsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, top: 10),
      height: height,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.zero,
          itemCount: 6,
          itemBuilder: (context, index) {
            return ShimmerWidget(
                shimmerWidth: width, shimmerHieght: 70.h, shimmerRadius: 12);
          }),
    );
  }
}
