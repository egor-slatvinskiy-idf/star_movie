import 'package:flutter/material.dart';
import 'package:presentation/library/images_utils/images_utils.dart';

FadeInImage imagePoster({
  required String imageNetwork,
}) {
  return FadeInImage.assetNetwork(
    placeholder: ImagesUtils.imageStarMovie,
    image: imageNetwork,
    fit: BoxFit.cover,
    imageErrorBuilder: (
      context,
      error,
      stackTrace,
    ) {
      return Image.asset(
        ImagesUtils.imageStarMovie,
        fit: BoxFit.cover,
      );
    },
  );
}
