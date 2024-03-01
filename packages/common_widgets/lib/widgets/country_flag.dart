import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class FlagWidget extends StatelessWidget {
  final double width;
  final double height;
  final String code;
  final String? langCode;
  final double? borderRadius;

  const FlagWidget({
    super.key,
    required this.width,
    required this.height,
    required this.code,
    this.borderRadius,
    this.langCode,
  });

  @override
  Widget build(BuildContext context) {
    return langCode != null
        ? CountryFlag.fromCountryCode(
            langCode!,
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
