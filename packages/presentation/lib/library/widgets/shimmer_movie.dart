import 'package:flutter/material.dart';
import 'package:presentation/library/widgets/shimmer_widget.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/dimens/dimens.dart';

const _itemCount = 6;
const _axisCount = 2;

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (Dimens.size01 / Dimens.size021),
        crossAxisCount: _axisCount,
        mainAxisSpacing: Dimens.size30,
        crossAxisSpacing: Dimens.size8,
      ),
      itemBuilder: (_, index) {
        return Shimmer.fromMyShimmer(
          child: Column(
            children: const [
              _ShimmerItem(height: Dimens.size300),
              SizedBox(height: Dimens.size16),
              _ShimmerItem(height: Dimens.size12),
              SizedBox(height: Dimens.size6),
              _ShimmerItem(height: Dimens.size14),
              SizedBox(height: Dimens.size6),
              _ShimmerItem(height: Dimens.size12),
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
