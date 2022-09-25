import 'package:flutter/material.dart';
import 'package:presentation/Library/widgets/shimmer_widget.dart';
import 'package:presentation/app_colors/app_colors.dart';
import 'package:presentation/library/dimens/dimens.dart';

class ShimmerDetailsCast extends StatelessWidget {
  const ShimmerDetailsCast({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromMyShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.padding18,
        ),
        child: Column(
          children: const [
            _ShimmerItem(height: Dimens.height40),
            SizedBox(height: Dimens.height16),
            _ShimmerItem(height: Dimens.height40),
            SizedBox(height: Dimens.height16),
            _ShimmerItem(height: Dimens.height40),
            SizedBox(height: Dimens.height16),
            _ShimmerItem(height: Dimens.height40),
          ],
        ),
      ),
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  final double height;

  const _ShimmerItem({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.colorBorder,
      ),
    );
  }
}
