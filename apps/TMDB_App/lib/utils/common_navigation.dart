import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/routes/route_name.dart';

class CommonNavigation {
  static void redirectToDetailScreen(
    BuildContext context, {
    String? mediaType = ApiKey.movie,
    String? mediaId = "609681",
  }) {
    if (kIsWeb) {
      context.go("${RouteName.home}/$mediaType/$mediaId");
      return;
    }

    context.push("${RouteName.home}/$mediaType/$mediaId");
  }
}
