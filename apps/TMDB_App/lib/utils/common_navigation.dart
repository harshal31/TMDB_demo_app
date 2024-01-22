import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/constants/api_key.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

class CommonNavigation {
  static void redirectToDetailScreen(
    BuildContext context, {
    String? mediaType = ApiKey.movie,
    String? movieId = "609681",
  }) {
    context.goNamed(
      mediaType ?? RouteName.movie,
      pathParameters: {RouteParam.id: movieId ?? ""},
    );
  }
}