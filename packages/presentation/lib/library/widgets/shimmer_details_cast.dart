import 'package:flutter/material.dart';
import 'package:presentation/library/widgets/shimmer_widget.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/dimens/dimens.dart';

class ShimmerDetailsCast extends StatelessWidget {
  const ShimmerDetailsCast({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromMyShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.size18,
        ),
        child: Column(
          children: const [
            _ShimmerItem(height: Dimens.size40),
            SizedBox(height: Dimens.size16),
            _ShimmerItem(height: Dimens.size40),
            SizedBox(height: Dimens.size16),
            _ShimmerItem(height: Dimens.size40),
            SizedBox(height: Dimens.size16),
            _ShimmerItem(height: Dimens.size40),
          ],
        ),
      ),
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
