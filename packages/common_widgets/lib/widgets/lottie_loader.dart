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
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.5,
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      child: AppAsset.json.loader.lottie(
        package: "common_widgets",
        width: width ?? MediaQuery.of(context).size.width * 0.5,
        height: height ?? MediaQuery.of(context).size.height * 0.5,
        alignment: Alignment.center,
      ),
    );
  }
}
