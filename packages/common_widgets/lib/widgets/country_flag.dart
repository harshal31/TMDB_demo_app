import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class FlagWidget extends StatelessWidget {
  final double width;
  final double height;
  final String code;
  final double? borderRadius;
  final bool isFromCountryCode;

  const FlagWidget({
    super.key,
    required this.width,
    required this.height,
    required this.code,
    this.isFromCountryCode = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return isFromCountryCode
        ? CountryFlag.fromCountryCode(
            code,
            height: width,
            width: height,
            borderRadius: borderRadius ?? 8,
          )
        : CountryFlag.fromCountryCode(
            code,
            height: width,
            width: height,
            borderRadius: borderRadius ?? 8,
          );
  }
}
