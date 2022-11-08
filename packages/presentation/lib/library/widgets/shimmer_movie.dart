import 'package:flutter/material.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/library/const/constants.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/widgets/shimmer_widget.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: Constants.itemCountShimmerMovie,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: (Dimens.size01 / Dimens.size021),
        mainAxisSpacing: Dimens.size30H,
        crossAxisSpacing: Dimens.size8W,
        maxCrossAxisExtent: Dimens.size180,
      ),
      itemBuilder: (_, index) {
        return Shimmer.fromMyShimmer(
          child: Column(
            children: [
              Expanded(
                child: _ShimmerItem(height: Dimens.size300H),
              ),
              SizedBox(height: Dimens.size16H),
              _ShimmerItem(height: Dimens.size12H),
              SizedBox(height: Dimens.size6H),
              _ShimmerItem(height: Dimens.size12H),
              SizedBox(height: Dimens.size6H),
              _ShimmerItem(height: Dimens.size12H),
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
