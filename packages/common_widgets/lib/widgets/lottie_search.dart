import 'package:common_widgets/gen/app_asset.dart';
import 'package:flutter/material.dart';

class LottieSearch extends StatelessWidget {
  final double? width;
  final double? height;

  const LottieSearch({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.5,
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      child: AppAsset.json.search.lottie(
        package: "common_widgets",
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        alignment: Alignment.center,
      ),
    );
  }
}
