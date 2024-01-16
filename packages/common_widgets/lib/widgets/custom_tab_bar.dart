import 'package:common_widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> titles;
  final Color? tabBarBorderColor;
  final LinearGradient? indicatorGradientColor;
  final Color? selectedColor;
  final Color? indicatorColor;
  final double? borderRadius;
  final bool? isScrollable;
  final TabAlignment? tabAlignment;
  final double? width;
  final Function(int)? onSelectedTab;
  final int? initialIndex;

  const CustomTabBar({
    super.key,
    required this.titles,
    this.tabBarBorderColor,
    this.indicatorGradientColor,
    this.selectedColor,
    this.indicatorColor,
    this.borderRadius,
    this.isScrollable,
    this.tabAlignment,
    this.width,
    this.onSelectedTab,
    this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 30),
        border: Border.all(
          color: tabBarBorderColor ?? context.colorTheme.primaryContainer,
          width: 1,
        ),
      ),
      child: DefaultTabController(
        initialIndex: initialIndex ?? 0,
        length: titles.length,
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? 30,
            ),
          ),
          child: TabBar(
            padding: EdgeInsets.zero,
            indicatorWeight: 0,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 30),
              color: indicatorColor ?? context.colorTheme.onPrimaryContainer,
              gradient: indicatorGradientColor,
            ),
            unselectedLabelStyle: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            onTap: (s) {
              onSelectedTab?.call(s);
            },
            isScrollable: isScrollable ?? false,
            tabAlignment: tabAlignment,
            labelStyle: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: selectedColor ?? context.colorTheme.onPrimary,
            ),
            tabs: titles
                .map((e) => Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(e),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
