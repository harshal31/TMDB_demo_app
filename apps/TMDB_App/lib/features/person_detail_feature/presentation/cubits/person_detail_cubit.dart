import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/person_detail_feature/presentation/use_cases/person_detail_use_case.dart';

class PersonDetailCubit extends Cubit<PersonDetailState> {
  final PersonDetailUseCase _personCreditUseCase;

  PersonDetailCubit(this._personCreditUseCase) : super(PersonDetailState.initial());

  void fetchPersonDetails(String personId) async {
    emit(state.copyWith(personDetailStatus: PersonDetailLoading()));
    final response = await _personCreditUseCase.fetchPersonDetails(personId);

    response.fold((l) {
      emit(
        state.copyWith(personDetailStatus: PersonDetailFailed(l.errorMessage)),
      );
    }, (r) {
      emit(
        state.copyWith(personDetailStatus: PersonDetailSuccess(), personDetailModel: r),
      );
    });
  }
}
