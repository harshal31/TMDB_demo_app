import 'package:flutter/material.dart';

class LinearLoader extends StatelessWidget {
  final double? width;
  final double? height;

  const LinearLoader({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: LinearProgressIndicator(),
    );
  }
}

// AppAsset.json.loader.lottie(
// package: "common_widgets",
// width: width ?? MediaQuery.of(context).size.width * 0.5,
// height: height ?? MediaQuery.of(context).size.height * 0.5,
// alignment: Alignment.center,
// )
