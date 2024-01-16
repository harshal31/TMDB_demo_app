import 'package:equatable/equatable.dart';
import 'package:tmdb_app/features/home_feature/data/home_api_service.dart';

class LatestUseCase {
  final HomeApiService _homeApiService;

  LatestUseCase(this._homeApiService);
}

class LatestState with EquatableMixin {
  LatestState();

  factory LatestState.initial() {
    return LatestState();
  }

  @override
  List<Object?> get props => [];
}
