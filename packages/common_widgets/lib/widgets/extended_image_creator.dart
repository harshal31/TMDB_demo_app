import 'package:common_widgets/gen/app_asset.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExtendedImageCreator extends StatefulWidget {
  final String? imageUrl;
  final String? fallbackUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final bool shouldDisplayErrorImage;
  final Color? imageColor;

  const ExtendedImageCreator({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.fallbackUrl,
    this.shape,
    this.borderRadius,
    this.shouldDisplayErrorImage = true,
    this.imageColor,
  });

  static Future<void> clearImageDiskCache() async {
    if (!kIsWeb) {
      await clearDiskCachedImages(
        duration: const Duration(days: 1),
      );
    }
  }

  static ExtendedImage getImage(
    String? url, {
    bool shouldDisplayErrorImage = false,
    double? width,
    double? height,
    BoxFit? fit,
    BoxShape? shape,
    BorderRadius? borderRadius,
  }) {
    return ExtendedImage.network(
      url ?? "",
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      fit: fit ?? BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      loadStateChanged: (s) {
        if (s.extendedImageLoadState == LoadState.failed && shouldDisplayErrorImage) {
          return Center(
            child: AppAsset.images.error.image(
              package: "common_widgets",
              fit: BoxFit.contain,
            ),
          );
        }

        return null;
      },
      shape: shape ?? BoxShape.rectangle,
      borderRadius: borderRadius ?? BorderRadius.zero,
      clearMemoryCacheWhenDispose: true,
      cache: true,
    );
  }

  @override
  State<ExtendedImageCreator> createState() => _ExtendedImageCreatorState();
}

class _ExtendedImageCreatorState extends State<ExtendedImageCreator> {
  late String imageUrl;
  ImageProvider? imageProvider;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit ?? BoxFit.fill,
      clipBehavior: Clip.hardEdge,
      color: widget.imageColor,
      loadStateChanged: (s) {
        if (s.extendedImageLoadState == LoadState.failed && widget.shouldDisplayErrorImage) {
          return Center(
            child: AppAsset.images.error.image(
              package: "common_widgets",
              fit: BoxFit.contain,
            ),
          );
        }

        return null;
      },
      shape: widget.shape ?? BoxShape.rectangle,
      borderRadius: widget.borderRadius ??
          const BorderRadius.all(
            Radius.circular(10.0),
          ),
      clearMemoryCacheWhenDispose: true,
    );
  }
}
