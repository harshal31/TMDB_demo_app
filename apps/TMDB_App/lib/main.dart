import "package:common_widgets/localizations/app_localizations.dart";
import "package:flutter/material.dart";
import "package:responsive_framework/responsive_framework.dart";
import "package:tmdb_app/app_level_provider/app_provider.dart";
import "package:tmdb_app/constants/app_constant.dart";
import "package:tmdb_app/constants/hive_key.dart";
import "package:tmdb_app/data_storage/hive_manager.dart";
import "package:tmdb_app/routes/app_router.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:tmdb_app/theme/app_theme.dart";

void main() async {
  await initializeDependencies();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child ?? SizedBox.shrink(),
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
  WidgetsFlutterBinding.ensureInitialized();
  await HiveManager.createHiveManager().initialize(HiveKey.appBoxName);
  AppProviders.registerAppLevelProviders();
}
