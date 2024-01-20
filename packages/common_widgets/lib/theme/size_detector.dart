import "package:flutter/cupertino.dart";
import "package:responsive_framework/responsive_framework.dart";

class SizeDetector extends StatelessWidget {
  final Widget Function() mobileBuilder;
  final Widget Function() tabletBuilder;
  final Widget Function() desktopBuilder;

  const SizeDetector({
    super.key,
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final value = ResponsiveBreakpoints.of(context);
    Widget widget;
    if (value.isPhone || value.isMobile) {
      widget = mobileBuilder.call();
    } else if (value.isTablet) {
      widget = tabletBuilder.call();
    } else if (value.isDesktop) {
      widget = desktopBuilder.call();
    } else {
      widget = SizedBox.shrink();
    }
    return SafeArea(
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        duration: Duration(milliseconds: 400),
        child: widget,
        curve: Curves.linear,
      ),
    );
  }
}
