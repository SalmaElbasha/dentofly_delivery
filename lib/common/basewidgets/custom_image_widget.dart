import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';

class CustomImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  const CustomImageWidget({Key? key, required this.image, this.height, this.width, this.fit = BoxFit.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  image != null && image.isNotEmpty
        ? CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Image.asset(Images.placeholder, height: height, width: width, fit: fit),
      errorWidget: (context, url, error) => Image.asset(Images.placeholder, height: height, width: width, fit: fit),
    )
        : Image.asset(Images.placeholder, height: height, width: width, fit: fit);

  }
}
