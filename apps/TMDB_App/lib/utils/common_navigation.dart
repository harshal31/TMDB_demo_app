import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

class CommonNavigation {
  static void redirectToDetailScreen(
    BuildContext context, {
    String? mediaType = ApiKey.movie,
    String? mediaId = "609681",
  }) {
    if (kIsWeb) {
      context.goNamed(
        mediaType ?? RouteName.movie,
        pathParameters: {RouteParam.id: mediaId ?? ""},
      );
      return;
    }

    context.pushNamed(
      mediaType ?? RouteName.movie,
      pathParameters: {RouteParam.id: mediaId ?? ""},
    );
  }
}
