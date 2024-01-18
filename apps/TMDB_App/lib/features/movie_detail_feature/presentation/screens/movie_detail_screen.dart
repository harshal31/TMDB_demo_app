import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/mobile/movie_detail_mobile_screen.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/tablet/movie_detail_tablet_screen.dart';
import 'package:tmdb_app/features/movie_detail_feature/presentation/screens/web/movie_detail_web_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizeDetector(
          mobileBuilder: () => MovieDetailMobileScreen(),
          tabletBuilder: () => MovieDetailTabletScreen(),
          desktopBuilder: () => MovieDetailWebScreen(),
        ),
      ),
    );
  }
}
