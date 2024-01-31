import 'package:common_widgets/theme/size_detector.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/features/search_feature/presentation/screens/web/search_web_screen.dart';

class SearchScreen extends StatelessWidget {
  final String searchType;
  final String query;
  final int page;

  const SearchScreen({
    super.key,
    required this.searchType,
    required this.query,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizeDetector(
          mobileBuilder: () => Container(),
          tabletBuilder: () => Container(),
          desktopBuilder: () => SearchWebScreen(
            searchType: searchType,
            query: query,
            page: page,
          ),
        ),
      ),
    );
  }
}
