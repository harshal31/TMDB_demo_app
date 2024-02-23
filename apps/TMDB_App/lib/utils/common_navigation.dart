import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmdb_app/routes/route_name.dart';
import 'package:tmdb_app/routes/route_param.dart';

class CommonNavigation {
  static void redirectToDetailScreen(
    BuildContext context, {
    String? mediaType = RouteParam.movie,
    String? mediaId = "609681",
  }) {
    context.push("${RouteName.home}/$mediaType/$mediaId");
  }

  static void redirectToVideosScreen(
    BuildContext context, {
    String? mediaType = RouteParam.movie,
    String? mediaId = "609681",
  }) {
    context.push("${RouteName.home}/$mediaType/$mediaId/${RouteName.videos}");
  }

  static void redirectToReviewsScreen(
    BuildContext context, {
    String? mediaType,
    int? mediaId,
  }) {
    context.push(
      Uri(
        path: "${RouteName.home}/$mediaType/$mediaId/${RouteName.reviews}",
      ).toString(),
    );
  }

  static void redirectToCastScreen(
    BuildContext context, {
    String? mediaType,
    int? mediaId,
  }) {
    context.push(
      Uri(
        path: "${RouteName.home}/$mediaType/$mediaId/${RouteName.cast}",
      ).toString(),
    );
  }

  static void redirectToKeywordsScreen(
    BuildContext context, {
    String? type,
    int? id,
    Object? extra,
  }) {
    context.push(
      Uri(
        path: "${RouteName.home}/${RouteName.keywords}/$type/$id",
      ).toString(),
      extra: extra,
    );
  }

  static void redirectToCompaniesScreen(
    BuildContext context, {
    String? type,
    int? id,
    Object? extra,
  }) {
    context.push(
      Uri(
        path: "${RouteName.home}/${RouteName.company}/$type/$id",
      ).toString(),
      extra: extra,
    );
  }
}
