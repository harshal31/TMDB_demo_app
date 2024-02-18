import "package:common_widgets/localizations/app_localizations.dart";
import "package:common_widgets/theme/app_theme.dart";
import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:go_router/go_router.dart";
import "package:responsive_framework/responsive_framework.dart";
import "package:tmdb_app/app_level_provider/app_provider.dart";
import "package:tmdb_app/constants/app_constant.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import "package:tmdb_app/routes/app_router.dart";

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDependencies();
  } else {
    final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
    await initializeDependencies();
    FlutterNativeSplash.remove();
  }
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.unknown
        },
      ),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter.goRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child ?? const SizedBox.shrink(),
        breakpoints: const [
          Breakpoint(start: AppConstant.mobMin, end: AppConstant.mobMax, name: MOBILE),
          Breakpoint(start: AppConstant.tabMin, end: AppConstant.tabMax, name: TABLET),
          Breakpoint(start: AppConstant.desktopMin, end: double.infinity, name: DESKTOP),
        ],
      ),
    );
  }
}

Future<void> initializeDependencies() async {
  usePathUrlStrategy();
  await HiveManager.createHiveManager().initialize(HiveKey.appBoxName);
  AppProviders.registerAppLevelProviders();
}
