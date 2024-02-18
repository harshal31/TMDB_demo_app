import 'package:common_widgets/gen/app_asset.dart';
import 'package:flutter/material.dart';

class LottieLoader extends StatelessWidget {
  final double? width;
  final double? height;

  const LottieLoader({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AppAsset.json.loader.lottie(
      package: "common_widgets",
      width: width,
      height: height,
    );
  }
}
