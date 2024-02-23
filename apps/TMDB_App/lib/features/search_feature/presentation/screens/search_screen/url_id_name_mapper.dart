import 'package:tmdb_app/routes/route_param.dart';

class UrlIdNameMapper {
  final String? value;
  final int? id;

  UrlIdNameMapper(this.value, this.id);

  static String getSearchDetailType(int index) {
    if (index == 0) {
      return RouteParam.movie;
    }
    if (index == 1) {
      return RouteParam.tv;
    }

    if (index == 2) {
      return RouteParam.person;
    }

    if (index == 3) {
      return RouteParam.keyword;
    }

    return RouteParam.company;
  }
}
