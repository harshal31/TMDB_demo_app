import "package:go_router/go_router.dart";
import 'package:tmdb_app/features/authentication_feature/presentation/screens/authentication_screen.dart';
import "package:tmdb_app/features/home_feature/presentation/screens/home_screen.dart";
import "package:tmdb_app/routes/route_name.dart";

final goRouter = GoRouter(
  initialLocation: RouteName.login,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: RouteName.login,
      builder: (ctx, state) {
        return AuthenticationScreen();
      },
    ),
    GoRoute(
      path: RouteName.home,
      builder: (ctx, state) {
        return HomeScreen();
      },
    ),
  ],
);
