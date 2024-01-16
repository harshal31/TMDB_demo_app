import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/latest_use_case.dart';
import 'package:tmdb_app/features/home_feature/presentation/use_case/trending_use_case.dart';

class LatestCubit extends Cubit<LatestState> {
  final TrendingUseCase _trendingUseCase;

  LatestCubit(this._trendingUseCase) : super(LatestState.initial());


  void fetchLatestResults() {

  }
}
