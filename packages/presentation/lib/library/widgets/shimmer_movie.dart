import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/widgets/shimmer_widget.dart';

const _itemCount = 14;

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (Dimens.size01 / Dimens.size021),
        crossAxisCount: Dimens.axisCountMovie(context),
        mainAxisSpacing: Dimens.size30.h,
        crossAxisSpacing: Dimens.size8.w,
      ),
      itemBuilder: (_, index) {
        return Shimmer.fromMyShimmer(
          child: Column(
            children: [
              Expanded(
                child: _ShimmerItem(height: Dimens.size300.h),
              ),
              SizedBox(height: Dimens.size16.h),
              _ShimmerItem(height: Dimens.size12.h),
              SizedBox(height: Dimens.size6.h),
              _ShimmerItem(height: Dimens.size12.h),
              SizedBox(height: Dimens.size6.h),
              _ShimmerItem(height: Dimens.size12.h),
            ],
          ),
        );
      },
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  final double height;

  const _ShimmerItem({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: ColorsApplication.colorBorder,
      ),
    );
  }
}
