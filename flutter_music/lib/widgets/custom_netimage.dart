import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class CustomNetImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double radius;
  final BoxFit fit;

  CustomNetImage(this.url,
      {this.width, this.height, this.radius = 5, this.fit = BoxFit.fill})
      : assert(url != null);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image(
        image: ExtendedNetworkImageProvider(url, cache: true),
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
