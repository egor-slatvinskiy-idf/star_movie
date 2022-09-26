import 'package:flutter/material.dart';
import 'package:presentation/Library/widgets/shimmer_widget.dart';
import 'package:presentation/colors_application/colors_application.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (.1 / .21),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (_, index) {
        return Shimmer.fromMyShimmer(
          child: Column(
            children: const [
              _ShimmerItem(height: 300),
              SizedBox(height: 16.44),
              _ShimmerItem(height: 12),
              SizedBox(height: 5),
              _ShimmerItem(height: 14),
              SizedBox(height: 5),
              _ShimmerItem(height: 12),
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
