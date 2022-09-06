import 'package:flutter/material.dart';
import 'package:presentation/app_colors/app_colors.dart';

const image = 'packages/presentation/images/image.jpg';

class MovieNowShowingWidget extends StatelessWidget {
  const MovieNowShowingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (.16 / .25),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
      ),
      itemBuilder: (_, index) {
        return Column(
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 16.44,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Title',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                Icon(
                  Icons.star,
                  size: 13,
                  color: AppColors.colorStars,
                ),
                Text(
                  'Movie Genres',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
